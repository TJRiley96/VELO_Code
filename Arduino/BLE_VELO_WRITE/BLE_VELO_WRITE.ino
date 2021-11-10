
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

const int pairingButton = 4;
const int LED_PWR = 14;
const int LED1 = 21;
const int LED2 = 32;
BLECharacteristic *pCharacteristic;
BLEServer *pServerAlias;
bool isConnected = false;
int txValue =  0;
String txArrStr[7];
bool pairingInterrupt = false;

#define SERVICE_UUID        "dda0643c-034e-4a75-ae4a-eb81af5db2b7"
#define CHARACTERISTIC_UUID "dda0643c-034e-4a75-ae4a-eb81af5db2b7"

#define RXD2 27 //GRAY WIRE
#define TXD2 33 //WHITE WIRE

#define AX_ANALOG_VAL 4095
#define BAT_VOLTAGE 3.7

class MyServerCallbacks: public BLEServerCallbacks{
    void onConnect(BLEServer *pServer){
        isConnected = true;
        digitalWrite(LED1, HIGH);
    };
    void onDisconnect(BLEServer *pServer){
        isConnected = false;
        //pairingInterrupt = true;
        digitalWrite(LED1, LOW);
    };
};

class MyCallbacks: public BLECharacteristicCallbacks{
    void onWrite(BLECharacteristic *pCharacteristic){
        std::string rxValue = pCharacteristic->getValue();
        if(rxValue.length() > 0){
            Serial.println("======START RECEIVING======");
            Serial.print("RECEIVED DATA: ");
            for(int i = 0; i < rxValue.length(); i++){
                Serial.print(rxValue[i]);
            }

            Serial.println();

            if(rxValue.find("1") != -1){
                Serial.println("LED2 ON!");
                digitalWrite(LED2, HIGH);
            }else if(rxValue.find("0") != -1){
                Serial.println("LED2 OFF!");
                digitalWrite(LED2, LOW);
            }
            Serial.println();
            Serial.println("=======END RECEIVING========");
        }
    }
};

void pairingISR(){
    Serial.println("INTERUPPT: BUTTON PUSH");
    pairingInterrupt = true;
}
void setup(){
    pinMode(pairingButton, INPUT);
    attachInterrupt(digitalPinToInterrupt(pairingButton), pairingISR, FALLING);
    pinMode(LED1, OUTPUT);
    pinMode(LED2, OUTPUT);
    pinMode(LED_PWR, OUTPUT);
    digitalWrite(LED_PWR, HIGH);
    Serial.begin(115200);
    Serial2.begin(115200, SERIAL_8N1, RXD2, TXD2);

    pairingInterrupt = false;
    //Create the BLE Device
    BLEDevice::init("ESP32_VELO_2");


    //Create BLE Server
    BLEServer *pServer = BLEDevice::createServer();
    pServer -> setCallbacks(new MyServerCallbacks());

    pServerAlias = &(*pServer);
    
    //Create the BLE Service
    BLEService *pService = pServer -> createService(SERVICE_UUID);

    //Create a BLE Characteristic
    pCharacteristic = pService -> createCharacteristic(
                                CHARACTERISTIC_UUID,
                                BLECharacteristic::PROPERTY_NOTIFY |
                                BLECharacteristic::PROPERTY_WRITE
                                );

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
    if(pairingInterrupt){
        pServerAlias->getAdvertising()->start();
        Serial.println("Waiting for client reconnection to notify...");
        pairingInterrupt = false;
    }
    if(isConnected){

        
        int rawValue = analogRead(A13);
        float voltageLevel = (rawValue / 4095.0) * 2 * 1.1 * 3.3; // calculate voltage level
        float batteryFraction = voltageLevel / BAT_VOLTAGE;

        Serial.println((String)"Raw:" + rawValue + " Voltage:" + voltageLevel + "V Percent: " + (batteryFraction * 100) + "%");
        int txArr[7];
        txValue =  random(-10, 20);
        txArr[0] = millis();
        txArr[1] = random(0, 30);
        txArr[2] = random(0, 10);
        txArr[3] = random(-300, 500);
        txArr[4] = random(-300, 500);
        txArr[5] = random(-300, 500);
        txArr[6] = 4;
        String tempString;
        char txString[8];
        char txData[128];
        for(int j = 0; j < 7; j++){
            dtostrf(txArr[j], 1, 2, txString);
            tempString += String(txString);
            if(j <= 5){
                tempString += ", ";  
            } 
        }
        Serial2.write(0xFF);
        tempString = tempString + ", " + Serial2.readString();

        tempString = tempString + ", %" + String(batteryFraction*100);
        //Serial.println(tempString);
        //Serial.println(digitalRead(pairingButton));
        tempString.toCharArray(txData, 128);
        Serial.println(Serial2.readString());
        Serial.println(txData);
       // txArrStr[0] = txArrStr[0] + "," + txArrStr[1] + "," + txArrStr[2] + "," + txArrStr[3] + "," + txArrStr[4] + "," + txArrStr[5] + "," + txArrStr[6];
        //Setting the value to the characteristic
        pCharacteristic -> setValue(txData);

        //Notifying the connected the client
        pCharacteristic->notify();
        //Serial.println("Sent Value: [" + txArrStr[0] + "," + txArrStr[1] + "," + txArrStr[2] + "," + txArrStr[3] + "," + txArrStr[4] + "," + txArrStr[5] + "," + txArrStr[6] + "]");
        delay(50);
    }
	
}
