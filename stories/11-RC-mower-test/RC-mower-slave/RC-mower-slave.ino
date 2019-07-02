#include <Wire.h>

int RPWM=5;
int LPWM=6;
int L_EN=7;
int R_EN=8;

void setPWMfrequency(int freq){
  TCCR0B = TCCR0B & 0b11111000 | freq;
}
 
void MotorActiveStatus(char side, boolean state){
  if(side == 'R') {
    digitalWrite(R_EN,state);
  }
  if(side == 'L') {
    digitalWrite(L_EN,state);
  }    
}
void setMotor(char side, byte pwm){
  if(side == 'R') {
    analogWrite(RPWM,pwm);
  }
  if(side == 'L') {
    analogWrite(LPWM,pwm);
  }
}

void closeMotor(char side){
  if(side == 'R') {
    digitalWrite(RPWM,LOW);
  }
  if(side == 'L') {
    digitalWrite(LPWM,LOW);
  }
}

void receiveEvent(int bytes) {
  int speed = Wire.read();    // read one character from the I2C
  if(speed > 0)
    setMotor('R', speed);
  else if(speed < 0)
    setMotor('L', abs(speed));
  else
    closeMotor('L');
}

void setup() {
  // Start the I2C Bus as Slave on address 9
  Wire.begin(9); 
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);
  
  setPWMfrequency(0x02);// timer 0 , 3.92KHz
  
  for(int i=5;i<9;i++) {
    pinMode(i,OUTPUT);
  }
  for(int i=5;i<9;i++) {
    digitalWrite(i,LOW);
  }
  
  delay(1000);
  
  MotorActiveStatus('R',true);
  MotorActiveStatus('L',true);
}

void loop() {
  delay(500);
}
