#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>

/* Set the delay between fresh samples */
#define BNO055_SAMPLERATE_DELAY_MS (1000)
Adafruit_BNO055 bno1 = Adafruit_BNO055(1, 0x28);


#include <HardwareSerial.h>
#define RXD2 33
#define TXD2 27

int s;
int v;
int v0;
int a;
int t; 


void setup() {

  Serial.begin(115200);
  Serial.println("Orientation Sensor Raw Data Test"); Serial.println("");

  /* Initialise the sensor */
  if(!bno1.begin())
  {
    /* There was a problem detecting the BNO055 ... check your connections */
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }

  Serial2.begin(115200, SERIAL_8N1, RXD2, TXD2);
  delay(1000);

  /* Display the current temperature */
  int8_t temp1 = bno1.getTemp();
  Serial.print("Current Temperature: ");
  Serial.print(temp1);
  Serial.println(" C");
  Serial.println("");

  bno1.setExtCrystalUse(true);

  Serial.println("Calibration status values: 0=uncalibrated, 3=fully calibrated");

  Serial2.write("CD=1\r");
  delay(100);
  Serial2.write("CP=0\r");
  delay(1000);
  Serial.println("Written");  

}

void loop() {

  // Possible vector values can be:
  // - VECTOR_ACCELEROMETER - m/s^2
  // - VECTOR_MAGNETOMETER  - uT
  // - VECTOR_GYROSCOPE     - rad/s
  // - VECTOR_EULER         - degrees
  // - VECTOR_LINEARACCEL   - m/s^2
  // - VECTOR_GRAVITY       - m/s^2
  imu::Vector<3> euler1 = bno1.getVector(Adafruit_BNO055::VECTOR_EULER);

  /* Display the floating point data */
  Serial.print("BNO1:");
  Serial.print("\t");
  Serial.print("X: ");
  Serial.print("\t");
  Serial.print(euler1.x());
  Serial.print("\t");
  Serial.print(" Y: ");
  Serial.print("\t");
  Serial.print(euler1.y());
  Serial.print("\t");
  Serial.print(" Z: ");
  Serial.print("\t");
  Serial.print(euler1.z());
  Serial.print("\t\t");
  Serial.print("\n");
  

  
//  // Quaternion data
//  imu::Quaternion quat1 = bno1.getQuat();
//  Serial.print("BNO1 "); 
//  Serial.print("qW: ");
//  Serial.print(quat1.w(), 4);
//  Serial.print(" qX: ");
//  Serial.print(quat1.x(), 4);
//  Serial.print(" qY: ");
//  Serial.print(quat1.y(), 4);
//  Serial.print(" qZ: ");
//  Serial.print(quat1.z(), 4);
//  Serial.print("\t\t");



  
  

//  /* Display calibration status for each sensor. */
//  uint8_t system, gyro, accel, mag = 0;
//  bno1.getCalibration(&system, &gyro, &accel, &mag);
//  Serial.print("CALIBRATION: Sys=");
//  Serial.print("\t");
//  Serial.print(system, DEC);
//  Serial.print("\t");
//  Serial.print(" Gyro=");
//  Serial.print("\t");
//  Serial.print(gyro, DEC);
//  Serial.print("\t");
//  Serial.print(" Accel=");
//  Serial.print("\t");
//  Serial.print(accel, DEC);
//  Serial.print("\t");
//  Serial.print(" Mag=");
//  Serial.print("\t");
//  Serial.println(mag, DEC);

  delay(10);
//
//  Serial2.write(0x00);
//  while (Serial2.available() > 0){
//      Serial.write(Serial2.read());
//      //Serial.print("done");
//  }
  delay(BNO055_SAMPLERATE_DELAY_MS);


}
//
//void vel1{
//  
//}
//
//void vel2{
//  
//}
//
//void avgVel{
//  
//}
