#include <Wire.h>
#include "FlySkyiBus.h"

// ----------------------
/*Relay Switches*/
#define RELAY_MOTOR_CUT 5
#define RELAY_MOTORS_GEAR 6

// CONST - Radio
struct PacketRadio {
    int cutSpeed;
    int gearLeftSpeed;
    int gearRightSpeed;
};

FlySkyiBus iBus(2, 2); // RX, TX
boolean mowingSystemRotorEnabled = false;

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

  // Set the relay on.
  pinMode(RELAY_MOTOR_CUT, OUTPUT);
  pinMode(RELAY_MOTORS_GEAR, OUTPUT);
  delay(5);
  digitalWrite(RELAY_MOTOR_CUT, HIGH);
  digitalWrite(RELAY_MOTORS_GEAR, HIGH);

  Serial.println("Welcome!");
  iBus.begin(115200);
}

void loop() {
  iBus.read_serial();

  // Channels:
  // - 2 for speed
  // - 0 for direction
  // - 7 activate mower
  // - 8 for mower rotor speed

  int ctrlActivate = iBus.get_channel(7); // 1000 or 2000
  // By default all controls are at low
  if(ctrlActivate > 1500) {

    // power up through relays
    if(mowingSystemRotorEnabled == false) {
      digitalWrite(RELAY_MOTOR_CUT, LOW);
      digitalWrite(RELAY_MOTORS_GEAR, LOW);
      mowingSystemRotorEnabled = true;
    }      
    
    int ctrlSpeed = iBus.get_channel(2); // 1000 to 2000
    int ctrlDir = iBus.get_channel(0);   // 1000 to 2000, centered at 1500
    int ctrlRotorSpeed = iBus.get_channel(8);   // 1000 to 2000
    
    int computedSpeed = map(ctrlSpeed, 1000, 2000, -255, 255);
    int computedDir = map(ctrlDir, 1000, 2000, -250, 250);
    
    int computedSpeedLeft, computedSpeedRight;
  
    if(computedSpeed > 0) {
      // forward
      computedSpeedLeft = computedSpeed - computedDir;
      computedSpeedRight = computedSpeed + computedDir;
    } else {
      // backward
      computedSpeedLeft = computedSpeed + computedDir;
      computedSpeedRight = computedSpeed - computedDir;
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
  } else {
    sendRotorsAction(5, 0, 0);
    delay(1);
    sendRotorsAction(0, 0, 0);
    
    // power down through relays
    if(mowingSystemRotorEnabled == true) {
      digitalWrite(RELAY_MOTOR_CUT, HIGH);
      digitalWrite(RELAY_MOTORS_GEAR, HIGH);
      mowingSystemRotorEnabled = false;
    }
  } 
}
