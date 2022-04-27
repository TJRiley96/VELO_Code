#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>

//Pin assignments for LEDs
const int LED3 = 21;
const int LED2 = 17;
const int LED1 = 16;

//GLobals for BLE
BLECharacteristic *pCharacteristic = NULL;
BLEServer *pServer = NULL;
bool isConnected = false;
bool pairingInterrupt = false;

#define SERVICE_UUID        "dda0643c-034e-4a75-ae4a-eb81af5db2b7"
#define CHARACTERISTIC_UUID "bf5b1cfa-3c99-4869-922c-6c95672b0ad1"
#define STATS_CHARACTERISTIC_UUID "99905484-c8d7-4f53-bab0-3c1fcd0a2707"
#define ORI_CHARACTERISTIC_UUID "68060827-d23a-4479-932c-f074367dc424"
#define FLEX_CHARACTERISTIC_UUID "db92bf37-ecfd-470f-83ef-0c7985ca2f35"


//Globals for IMU
Adafruit_BNO055 bno = Adafruit_BNO055(55);
sensors_event_t orientationData , angVelocityData , linearAccelData, magnetometerData;
/* Set the delay between fresh samples */
#define BNO055_SAMPLERATE_DELAY_MS (50)

//Globals for flex sensor
#define RXD2 33 //GRAY WIRE
#define TXD2 27 //WHITE 
float flex = 0.0;

//Get IMU and Flex Sensor data
TaskHandle_t Task1;
TaskHandle_t Task2;

//Push notify to application
TaskHandle_t TaskNotify;

//Function for getting sensor data
void getSensor(void * pvPrameter){
  for(;;){
    bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
    bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
    //flex = flexRead();
//    delay(BNO055_SAMPLERATE_DELAY_MS);
//    flexTest();
     vTaskDelay(50);
      
  }
}
void getFlex(void * pvPrameter){
  char buf[6];
  char dat[1];
  uint8_t num1, num2;
  int16_t num = 0;
  byte readSerial;
  for(;;){
    Serial2.write(0x00);
    while (Serial2.available() > 0){
      readSerial = Serial2.readBytesUntil('\n', buf, 6);
      Serial.print(buf[2], HEX);
      Serial.print("DEC: ");
      num2 = (uint8_t)buf[3];
      num1 = (uint8_t)buf[2];
//     num = num | num2;
      num = (num1<<8) + num2;
      Serial.print(num);
      flex = num/100.0;
//      delay(500);
    }
      Serial.println(); 
     vTaskDelay(30);
  }
}


//Function for notifying
void doNotify(void * pvPrameter){
  for(;;){
  char buf[100];
    // A string holding read data to return to the client.
    std::string ret;

    if(isConnected){
        snprintf(buf, sizeof(buf), "%g,%g,%g", linearAccelData.acceleration.z, orientationData.orientation.z, flex);
//        Serial.println(buf);
        ret.assign(buf);
        pCharacteristic->setValue(ret);
        pCharacteristic->notify();
        
        vTaskDelay(3);
      }else{
        delay(500);
      }
  }
}


//Configure IMU
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
//Configure Flex Sensor
void FLEX_CONFIG(){
//  
//  delay(1000);
//  Serial2.write("CD=0\r");
//  delay(1);
//  Serial2.write("CP=0\r");
//  Serial2.write("CR=1\r");
//  Serial.println("Setup complete");
//  delay(1000);
}

////Fucntion for parsing flex sensor data
//void try2(){
//  byte buf[6];
//  uint8_t byte1, byte2;
//  uint16_t full = 0;
//  float sendFlex = 0.0;
//  
//  Serial2.write(0xFF);
//  while (Serial2.available() > 0){
//    if(Serial2.readBytes(buf, 6)){
//      Serial.println("Data Found!!!!");
//      
//      byte1 = (uint8_t)buf[2];
//      byte2 = (uint8_t)buf[3];
//      
//      full = full | byte1;
//      full = full<<8| byte2;
//
//      Serial.println(full, HEX);
//      sendFlex = full / 100.0;      
//      Serial.println(sendFlex);
//      flex = sendFlex;
//      }else{
//        Serial.println("Serial found problem");
//      }
//  }
//  Serial.println();  
//}

//Function for testing purposes
void flexTest(){
  char buf1[6];
  byte readSerial;
  
  Serial2.write(0x00);
  while (Serial2.available() > 0){

    readSerial = Serial2.readBytesUntil('\n', buf1, 6);
    Serial.print(buf1[2], HEX);
    Serial.print("DEC: ");
    Serial.print(buf1[2], DEC);
  }
    Serial.println();
}
//float flexRead(){
//  Serial2.write(0xFF);
//  String tmp = Serial2.readString();
//  tmp.remove(5, (tmp.length()-4));
//  tmp.trim();
//  float fin = tmp.toFloat();
//  return fin;
//}

//Configure LEDS
void LED_CONFIG(){
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
}
//Currently unused function for switching LED
void ledSwitch(int LED){
  bool temp = digitalRead(LED);
  if(digitalRead(LED) == LOW){
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED,LOW);
  }
}

//BLE Server Callback function
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

//Class for reading battery statistics
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
     //BLE2902 needed to notify
    pCharacteristic -> addDescriptor(new BLE2902());

    //Create a BLE Characteristic
     BLECharacteristic *pCharacteristic = pService -> createCharacteristic(
                                STATS_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadStats());

   //Create tasks for cores
   xTaskCreatePinnedToCore(getSensor,"Task_1",10000, NULL, 0, &Task1, 1);
   xTaskCreatePinnedToCore(getFlex,"Task_2",10000, NULL, 0, &Task2, 1);
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
  delay(100);
}
