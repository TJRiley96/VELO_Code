
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>


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
class ReadStats: public MyCallbacks{
  float txArr0 = random(0.0, 100.0);
  float txArr1 = random(0.0, 4.5);
  float txArr2 = random(0.0, 5.0);
  //ledSwitch(21);

  
  #ifdef VERBOSE_RETURN
            snprintf(buf, sizeof(buf), "%f,%f,%f", txArr0, txArr1, txArr2);
            Serial.println(buf);
            ret.assign(buf);
  #endif
  
};
class ReadOrientation: public MyCallbacks{

  float txArr0 = random(0.0, 100.0);
  float txArr1 = random(0.0, 4.5);
  float txArr2 = random(0.0, 5.0);
 
  //ledSwitch(LED2);

  #ifdef VERBOSE_RETURN
            snprintf(buf, sizeof(buf),"%f,%f,%f", txArr0, txArr1, txArr2);
            Serial.println(buf);
            ret.assign(buf);
  #endif
};
class ReadFlex: public MyCallbacks{
  float tx = random(0, 100);;
  //ledSwitch(LED3);

  #ifdef VERBOSE_RETURN
            snprintf(buf, sizeof(buf), "%f", tx);
            Serial.println(buf);
            ret.assign(buf);
  #endif
};
void setup(){
    Serial.begin(115200);

    LED_CONFIG();
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
     pCharacteristic->setCallbacks(new ReadStats);
     
     pCharacteristic = pService -> createCharacteristic(
                                ORI_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadOrientation);
     
     pCharacteristic = pService -> createCharacteristic(
                                FLEX_CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_READ
                                );
     pCharacteristic->setCallbacks(new ReadFlex);

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
