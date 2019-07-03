#include <Wire.h>
#include "FlySkyiBus.h"

// ----------------------
// CONST - Radio
struct PacketRadio {
    int cutSpeed;
    int gearLeftSpeed;
    int gearRightSpeed;
};

FlySkyiBus iBus(2, 2); // RX, TX

void sendRotorsAction(int cutSpeed, int gearLeftSpeed, int gearRightSpeed) {
    PacketRadio packetRadio = { cutSpeed, gearLeftSpeed, gearRightSpeed };
    
    Wire.beginTransmission(9);  // transmit to device #9
    Wire.write((byte *)&packetRadio, sizeof packetRadio);
    Wire.endTransmission();     // stop transmitting
}

void setup() {
  Serial.begin(9600);
  Wire.begin(); 
  delay(2000);//delay for 2 sec

  Serial.println("Welcome!");
  iBus.begin(115200);
}

void loop() {
  iBus.read_serial();

  // Channels:
  // - 2 for speed
  // - 0 for direction
  // - 8 for mower rotor speed

  int ctrlSpeed = iBus.get_channel(2); // 1000 to 2000
  int ctrlDir = iBus.get_channel(0);   // 1000 to 2000, centered at 1500
  int ctrlRotorSpeed = iBus.get_channel(8);   // 1000 to 2000
  
  int computedSpeed = (ctrlSpeed - 1500) / 2; // -250 to +250
  int computedDir = (ctrlDir - 1500) / 2; // -250 to +250
  
  int computedSpeedLeft, computedSpeedRight;

  if(computedSpeed > 0) {
    // forward
    computedSpeedLeft = computedSpeed + computedDir;
    computedSpeedRight = computedSpeed - computedDir;
  } else {
    // backward
    computedSpeedLeft = computedSpeed - computedDir;
    computedSpeedRight = computedSpeed + computedDir;
  }
    
  Serial.print("Speed = ");
  Serial.print(computedSpeed);
  Serial.print("\tDir = ");
  Serial.print(computedDir);
  Serial.print("\t(L=");
  Serial.print(computedSpeedLeft);
  Serial.print(",R=");
  Serial.print(computedSpeedRight);
  Serial.print(")\n");

  sendRotorsAction(map(ctrlRotorSpeed, 1000, 2000, 0, 255), computedSpeedLeft, computedSpeedRight);
}
