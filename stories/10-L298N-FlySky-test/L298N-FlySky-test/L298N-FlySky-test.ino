#include "FlySkyiBus.h"

#define enA 9
#define in1 4
#define in2 5

#define enB 8
#define in3 6
#define in4 7

FlySkyiBus iBus(2, 2); // RX, TX

struct Motor {
    int pinPWM;
    int pinDir1;
    int pinDir2;
};

struct Motor motorLeft = { enA, in1, in2 };
struct Motor motorRight = { enB, in3, in4 };

// Speed = -500 => +500
void setMotor(Motor motor, int speed) {
  if(speed > 0) {
    // CCW
    digitalWrite(motor.pinDir1, HIGH);
    digitalWrite(motor.pinDir2, LOW);
    analogWrite(motor.pinPWM, min(speed,255) );
  } else {
    // CW
    digitalWrite(motor.pinDir1, LOW);
    digitalWrite(motor.pinDir2, HIGH);
    analogWrite(motor.pinPWM, min(-speed,255) );
  }
}

void setup() {
  Serial.begin(9600);

  Serial.println("Welcome!");
  iBus.begin(115200);
  
  pinMode(enA, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);

  pinMode(enB, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);

  setMotor(motorLeft, 0);
  setMotor(motorRight, 0);
}

void loop() {
  iBus.read_serial();

  // Channels:
  // - 2 for speed
  // - 0 for direction

  int ctrlSpeed = iBus.get_channel(2); // 1000 to 2000
  int ctrlDir = iBus.get_channel(0);   // 1000 to 2000, centered at 1500
  
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

  setMotor(motorLeft, computedSpeedLeft);
  setMotor(motorRight, computedSpeedRight); 
}
