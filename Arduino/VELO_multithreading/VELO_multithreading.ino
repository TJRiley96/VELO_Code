
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>


#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>


BLECharacteristic *pCharacteristic = NULL;
BLEServer *pServer = NULL;
bool isConnected = false;
bool pairingInterrupt = false;
#define RXD2 27 //GRAY WIRE
#define TXD2 33 //WHITE 
const int LED3 = 21;
const int LED2 = 17;
const int LED1 = 16;

#define SERVICE_UUID        "dda0643c-034e-4a75-ae4a-eb81af5db2b7"
#define CHARACTERISTIC_UUID "bf5b1cfa-3c99-4869-922c-6c95672b0ad1"
#define STATS_CHARACTERISTIC_UUID "99905484-c8d7-4f53-bab0-3c1fcd0a2707"
#define ORI_CHARACTERISTIC_UUID "68060827-d23a-4479-932c-f074367dc424"
#define FLEX_CHARACTERISTIC_UUID "db92bf37-ecfd-470f-83ef-0c7985ca2f35"



/* Set the delay between fresh samples */
#define BNO055_SAMPLERATE_DELAY_MS (50)
Adafruit_BNO055 bno = Adafruit_BNO055(55);
sensors_event_t orientationData , angVelocityData , linearAccelData, magnetometerData;
float flex = 0.0;
String test;

TaskHandle_t Task1;
TaskHandle_t TaskNotify;

void getSensor(void * pvPrameter){
  for(;;){
    bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
    bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
    //flex = flexRead();
    flexTest();
    delay(BNO055_SAMPLERATE_DELAY_MS);  
  }
}
void doNotify(void * pvPrameter){
  for(;;){
  char buf[100];
    // A string holding read data to return to the client.
    std::string ret;

    if(isConnected){
        snprintf(buf, sizeof(buf), "%g,%g,%g", linearAccelData.acceleration.x, orientationData.orientation.z, flex);
        Serial.println(buf);
        ret.assign(buf);
        pCharacteristic->setValue(ret);
        pCharacteristic->notify();
        
        delay(3);
      }else{
        delay(500);
      }
  }
}


void BNO_CONFIG(){
  Serial.println("Orientation Sensor Raw Data Test"); Serial.println("");

  /* Initialise the sensor */
  if(!bno.begin())
  {
    /* There was a problem detecting the BNO055 ... check your connections */
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }


  /* Display the current temperature */
  int8_t temp1 = bno.getTemp();
  Serial.print("Current Temperature: ");
  Serial.print(temp1);
  Serial.println(" C");
  Serial.println("");

  //bno.setExtCrystalUse(true);

  Serial.println("Calibration status values: 0=uncalibrated, 3=fully calibrated");
}
void FLEX_CONFIG(){
  
  delay(1000);
  Serial2.write("CD=1\r");
  delay(1);
  Serial2.write("CP=0\r");
  Serial2.write("CR=1\r");
  Serial.println("Setup complete");
  delay(1000);
}
void flexTest(){
  Serial2.write(0xFF);
  char buf[16];
  while (Serial2.available() > 0){
      snprintf(buf,sizeof(buf),"%d" ,Serial2.read());
      Serial.println(buf);
      //Serial.print("done");
  }
}
float flexRead(){
  Serial2.write(0xFF);
  String tmp = Serial2.readString();
  tmp.remove(5, (tmp.length()-4));
  tmp.trim();
  float fin = tmp.toFloat();
  return fin;
}

void LED_CONFIG(){
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
  }
void ledSwitch(int LED){
  bool temp = digitalRead(LED);
  if(digitalRead(LED) == LOW){
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED,LOW);
  }
}

class MyServerCallbacks: public BLEServerCallbacks{
    void onConnect(BLEServer *pServer){
        isConnected = true;
        digitalWrite(LED2, HIGH);
    };
    void onDisconnect(BLEServer *pServer){
        isConnected = false;
        digitalWrite(LED2, LOW);
        //pairingInterrupt = true;
    };
};

class ReadStats: public BLECharacteristicCallbacks{
  public:
  // A buffer for messages; a C string.
    char buf[100];
    // A string holding read data to return to the client.
    std::string ret;
  int rawValue;
  float voltageLevel, batteryFraction;
  ReadStats(){
    rawValue = analogRead(A13);
    voltageLevel = (rawValue / 4095.0) * 2 * 1.1 * 3.3 - 0.2; // calculate voltage level
    batteryFraction = (voltageLevel - 3.0) / 1.2 ;
  }
  void onRead(BLECharacteristic* pCharacteristic){
    rawValue = analogRead(A13);
    voltageLevel = (rawValue / 4095.0) * 2 * 1.1 * 3.3 - 0.2; // calculate voltage level
    batteryFraction = (voltageLevel - 3.0) / 1.2 ;
    snprintf(buf, sizeof(buf), "%f,%f", voltageLevel, batteryFraction);
    Serial.println(buf);
    ret.assign(buf);
    pCharacteristic->setValue(ret);
  }
  
};
//class ReadOrientation: public BLECharacteristicCallbacks{
//public:
//  // A buffer for messages; a C string.
//    char buf[100];
//    // A string holding read data to return to the client.
//    std::string ret;
//  sensors_event_t orientationData , angVelocityData , linearAccelData, magnetometerData;
//
//  ReadOrientation(){
//    bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
//    bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
//    Serial.println(xPortGetCoreID());
//    }
//    void onRead(BLECharacteristic* pCharacteristic){
//      int timeCnt = millis();
//      bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
//      bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
//      snprintf(buf, sizeof(buf), "%f,%f,%f", linearAccelData.acceleration.x, linearAccelData.acceleration.y, orientationData.orientation.z);
//      Serial.println(buf);
//      Serial.println(xPortGetCoreID());
//      ret.assign(buf);
//      pCharacteristic->setValue(ret);
//      Serial.print("Time: ");
//      Serial.println(millis()-timeCnt);
//      
//    }
//
//  //ledSwitch(LED2);
//
//};
//class ReadFlex: public BLECharacteristicCallbacks{
//  public:
//  // A buffer for messages; a C string.
//    char buf[100];
//    // A string holding read data to return to the client.
//    std::string ret;
//  float tx;
//  ReadFlex(){
//    tx = random(0,100);
//  }
//  //ledSwitch(LED3);
//  void onRead(BLECharacteristic* pCharacteristic){
//    tx = random(0,100);
//    snprintf(buf, sizeof(buf), "%f", tx);
//    Serial.println(buf);
//    ret.assign(buf);
//    pCharacteristic->setValue(ret);
//  }
//};
void setup(){
    Serial.begin(115200);
    Serial2.begin(115200, SERIAL_8N1, RXD2, TXD2);

    LED_CONFIG();

    BNO_CONFIG();

    FLEX_CONFIG();
    //Create the BLE Device
    BLEDevice::init("ESP32_VELO_2");

    //Create BLE Server
    pServer = BLEDevice::createServer();
    pServer -> setCallbacks(new MyServerCallbacks());
    
    //Create the BLE Service
    BLEService *pService = pServer -> createService(SERVICE_UUID);

    
     
     pCharacteristic = pService -> createCharacteristic(
                                ORI_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_NOTIFY
                                );
//     pCharacteristic->setCallbacks(new ReadOrientation());
     //BLE2902 needed to notify
    pCharacteristic -> addDescriptor(new BLE2902());

    //Create a BLE Characteristic
     BLECharacteristic *pCharacteristic = pService -> createCharacteristic(
                                STATS_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadStats());
     
//     pCharacteristic = pService -> createCharacteristic(
//                                FLEX_CHARACTERISTIC_UUID,
//                                BLECharacteristic::PROPERTY_READ
//                                );
//     pCharacteristic->setCallbacks(new ReadFlex());
   xTaskCreatePinnedToCore(getSensor,"Task_1",10000, NULL, 0, &Task1, 1);
   xTaskCreatePinnedToCore(doNotify,"Task_Notify",10000, NULL, 1, &TaskNotify, 0);


    
   // Start the service
  pService->start();

  // Start advertising
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  Serial.println("Waiting a client connection to notify...");

  
}

void loop(){
    delay(1);
  
}
