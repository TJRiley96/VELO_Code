
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>


#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>


BLECharacteristic *pCharacteristic;
BLEServer *pServer = NULL;
bool isConnected = false;
int txValue =  0;
String txArrStr[7];
bool pairingInterrupt = false;

const int LED1 = 21;
const int LED2 = 17;
const int LED3 = 16;

#define SERVICE_UUID        "dda0643c-034e-4a75-ae4a-eb81af5db2b7"
#define CHARACTERISTIC_UUID "bf5b1cfa-3c99-4869-922c-6c95672b0ad1"
#define STATS_CHARACTERISTIC_UUID "99905484-c8d7-4f53-bab0-3c1fcd0a2707"
#define ORI_CHARACTERISTIC_UUID "68060827-d23a-4479-932c-f074367dc424"
#define FLEX_CHARACTERISTIC_UUID "db92bf37-ecfd-470f-83ef-0c7985ca2f35"



/* Set the delay between fresh samples */
#define BNO055_SAMPLERATE_DELAY_MS (1000)
Adafruit_BNO055 bno = Adafruit_BNO055(55);

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

void LED_CONFIG(){
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, HIGH);
  digitalWrite(LED3, HIGH);
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
    };
    void onDisconnect(BLEServer *pServer){
        isConnected = false;
        //pairingInterrupt = true;
    };
};
class MyCallbacks: public BLECharacteristicCallbacks{
    public:
    // A buffer for messages; a C string.
    char buf[100];
    // A string holding read data to return to the client.
    std::string ret;
    // The value read from a characteristic.
    std::string value;

    MyCallbacks() : ret(100, 0) {
        ret.assign("Not yet invoked.");
    };

    // On a read, return ``buf``.
    void onRead(BLECharacteristic* pCharacteristic) {
        pCharacteristic->setValue(ret);
    };

    // Get a write value and check its length.
    bool checkLength(size_t sz_expected_length, BLECharacteristic* pCharacteristic) {
        value = pCharacteristic->getValue();
        if (value.length() != sz_expected_length) {
            snprintf(buf, sizeof(buf), "Error: message length was %u, but expected %u.\n", value.length(), sz_expected_length);
            ret.assign(buf);
            return false;
        }

        // The default response is an empty string.
        ret.clear();
        return true;
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
class ReadOrientation: public BLECharacteristicCallbacks{
public:
  // A buffer for messages; a C string.
    char buf[100];
    // A string holding read data to return to the client.
    std::string ret;
  sensors_event_t orientationData , angVelocityData , linearAccelData, magnetometerData;

  ReadOrientation(){
    bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
    bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
    }
    void onRead(BLECharacteristic* pCharacteristic){
      bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
      bno.getEvent(&linearAccelData, Adafruit_BNO055::VECTOR_LINEARACCEL);
      snprintf(buf, sizeof(buf), "%f,%f,%f", linearAccelData.acceleration.x, linearAccelData.acceleration.y, orientationData.orientation.z);
      Serial.println(buf);
      ret.assign(buf);
      pCharacteristic->setValue(ret);
    }

  //ledSwitch(LED2);

};
class ReadFlex: public BLECharacteristicCallbacks{
  public:
  // A buffer for messages; a C string.
    char buf[100];
    // A string holding read data to return to the client.
    std::string ret;
  float tx;
  ReadFlex(){
    tx = random(0,100);
  }
  //ledSwitch(LED3);
  void onRead(BLECharacteristic* pCharacteristic){
    tx = random(0,100);
    snprintf(buf, sizeof(buf), "%f", tx);
    Serial.println(buf);
    ret.assign(buf);
    pCharacteristic->setValue(ret);
  }
};
void setup(){
    Serial.begin(115200);

    LED_CONFIG();

    BNO_CONFIG();
    //Create the BLE Device
    BLEDevice::init("ESP32_VELO_2");

    //Create BLE Server
    BLEServer *pServer = BLEDevice::createServer();
    pServer -> setCallbacks(new MyServerCallbacks());
    
    //Create the BLE Service
    BLEService *pService = pServer -> createService(SERVICE_UUID);

    //Create a BLE Characteristic
    BLECharacteristic *pCharacteristic = pService -> createCharacteristic(
                                CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ|
                                BLECharacteristic::PROPERTY_WRITE
                                );
    pCharacteristic->setCallbacks(new MyCallbacks());
    
    pCharacteristic = pService -> createCharacteristic(
                                STATS_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadStats());
     
     pCharacteristic = pService -> createCharacteristic(
                                ORI_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadOrientation());
     
     pCharacteristic = pService -> createCharacteristic(
                                FLEX_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadFlex());

    //BLE2902 needed to notify
    pCharacteristic -> addDescriptor(new BLE2902());

   /* BLECharacteristic *pCharacteristic =  pService->createCharacteristic(
                                            CHARACTERISTIC_UUID,
                                            BLECharacteristic::PROPERTY_WRITE
                                        );*/

    pCharacteristic->setCallbacks(new MyCallbacks());
    
    //Start the service
    pService->start();

    //Start advertising
    pServer->getAdvertising()->start();
    Serial.println("Waiting for client connection to notify...");

  
}

void loop(){
  
}
