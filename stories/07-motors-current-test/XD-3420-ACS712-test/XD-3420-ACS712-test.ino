// Mixing XD-3420 + current sensor

const int analogIn = 0; //Connect current sensor with A0 of Arduino
// Scale Factors: 185 mV per Amp for 5A module, 100 mV per Amp for 20A, 66 mV per Amp for 30A
int mVperAmp = 185;
int RawValue= 0;
int ACSoffset = 2500; 
double Voltage = 0; //voltage measuring
double Amps = 0;// Current measuring

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

void setup() {
  Serial.begin(9600);//baud rate at which arduino communicates with Laptop/PC
  delay(2000);//delay for 2 sec

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

void displayCurrent() {
 RawValue = analogRead(analogIn);//reading the value from the analog pin
 Voltage = (RawValue / 1024.0) * 5000; // Gets you mV
 Amps = ((Voltage - ACSoffset) / mVperAmp);
 
 Serial.print("Raw Value = " ); // prints on the serial monitor
 Serial.print(RawValue); //prints the results on the serial monitor
 
 Serial.print("\t mV = "); // shows the voltage measured 
 Serial.print(Voltage,3); // the '3' after voltage allows you to display 3 digits after decimal point
 
 Serial.print("\t Amps = "); // shows the voltage measured 
 Serial.println(Amps,3);// the '3' after voltage allows you to display 3 digits after decimal point
}

void loop() //method to run the source code repeatedly
{ 
  for(int i=0;i<256;i++) {
    setMotor('R',i);
    delay(500);
    displayCurrent();
  }
  for(int i=255;i>0;i=i-2) {
    setMotor('R',i);
    delay(500);
    displayCurrent();
  }
  delay(1000);
  closeMotor('R');
  delay(1000);
  for(int i=0;i<256;i++) {
    setMotor('L',i);
    delay(500);
    displayCurrent();
  }
  for(int i=255;i>0;i=i-2) {
    setMotor('L',i);
    delay(500);
    displayCurrent();
  }
  delay(1000);
  closeMotor('L');
  delay(1000);
}
