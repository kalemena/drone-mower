#include <Wire.h>

// ----------------------
// I2C 
#define DEVICE_ID 9

// CONST - Motor cut
struct MotorCut {
    int pinRPWM;
    int pinLPWM;
    int pinL_EN;
    int pinR_EN;
};
struct MotorCut motorCut = { 5, 6, 7, 8 };

// ----------------------
// CONST - Motors gear
#define enA 9
#define in1 2
#define in2 11

#define enB 10
#define in3 12
#define in4 13

struct MotorGear {
    int pinPWM;
    int pinDir1;
    int pinDir2;
};

struct MotorGear motorGearLeft = { enA, in1, in2 };
struct MotorGear motorGearRight = { enB, in3, in4 };

// ----------------------
// CONST - Radio
struct PacketRadio {
    int cutSpeed;
    int gearLeftSpeed;
    int gearRightSpeed;
};

// ----------------------

// ----------------------
// CODE - Cutting grass motor
void setupMotorCut(MotorCut motor) {
  pinMode(motor.pinRPWM,OUTPUT);
  pinMode(motor.pinLPWM,OUTPUT);
  pinMode(motor.pinL_EN,OUTPUT);
  pinMode(motor.pinR_EN,OUTPUT);
  
  digitalWrite(motor.pinRPWM,LOW);  
  digitalWrite(motor.pinLPWM,LOW);
  digitalWrite(motor.pinL_EN,LOW);
  digitalWrite(motor.pinR_EN,LOW);
}

void setPWMfrequency(int freq){
  TCCR0B = TCCR0B & 0b11111000 | freq;
}
 
void activateMotorCutDirection(char side, boolean state) {
  if(side == 'R') {
    digitalWrite(motorCut.pinR_EN,state);
  }
  if(side == 'L') {
    digitalWrite(motorCut.pinL_EN,state);
  }    
}

void setMotorCut(char side, byte pwm) {
  if(side == 'R') {
    analogWrite(motorCut.pinRPWM,pwm);
  }
  if(side == 'L') {
    analogWrite(motorCut.pinLPWM,pwm);
  }
}

void closeMotorCut(char side){
  if(side == 'R') {
    digitalWrite(motorCut.pinRPWM,LOW);
  }
  if(side == 'L') {
    digitalWrite(motorCut.pinLPWM,LOW);
  }
}
// ----------------------

// ----------------------
// CODE - Gear motors
void setupMotorGear(MotorGear motor) {
  pinMode(motor.pinPWM, OUTPUT);
  pinMode(motor.pinDir1, OUTPUT);
  pinMode(motor.pinDir2, OUTPUT);
}

// Speed = -500 => +500
void setMotorGear(MotorGear motor, int speed) {
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
// ----------------------

void receiveEvent(int bytes) {
  PacketRadio packet;
  // read full struct from the I2C
  Wire.readBytes((byte*)&packet, bytes);
  
  // Motor Cut
  if(packet.cutSpeed > 0)
    setMotorCut('R', packet.cutSpeed);
  else if(packet.cutSpeed < 0)
    setMotorCut('L', abs(packet.cutSpeed));
  else
    closeMotorCut('L');

  // Motor Gear
  setMotorGear(motorGearLeft, packet.gearLeftSpeed);
  setMotorGear(motorGearRight, packet.gearRightSpeed);
}

void setup() {
  // Start the I2C Bus as Slave on address 9
  Wire.begin(DEVICE_ID); 
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);

  // Cut Motor
  setPWMfrequency(0x02);// timer 0 , 3.92KHz
  setupMotorCut(motorCut);
  delay(1000);
  activateMotorCutDirection('R',true);
  activateMotorCutDirection('L',true);
    
  // Gear Motors
  setupMotorGear(motorGearLeft);
  setupMotorGear(motorGearRight);  
  setMotorGear(motorGearLeft, 0);
  setMotorGear(motorGearRight, 0);
}

void loop() {
  delay(500);
}
