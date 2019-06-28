#include <Wire.h>

#define Relay_Motors 12

//Measuring Current Using ACS712
const int analogIn = 0; //Connect current sensor with A0 of Arduino
// Scale Factors: 185 mV per Amp for 5A module, 100 mV per Amp for 20A, 66 mV per Amp for 30A
int mVperAmp = 185;
int RawValue= 0;
int ACSoffset = 2500; 
double Voltage = 0; //voltage measuring
double Amps = 0;// Current measuring

boolean stopItNow = false;

void measureAndDisplay() {
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

void sendAction(int speed) {
    Serial.print("Sending = ");
    Serial.println(speed);
    Wire.beginTransmission(9);  // transmit to device #9
    Wire.write(speed);          // sends speed
    Wire.endTransmission();     // stop transmitting
}

void checkAndSendAction(int speed) {
  measureAndDisplay();
  
  if((Amps > 1) || (stopItNow == true)) {
    Serial.println("Security mode: STOP");
    stopItNow = true;
    sendAction(5);
    sendAction(0);
    digitalWrite(Relay_Motors, HIGH);
    delay(500);
  } 
  else 
  {
    sendAction(speed);
  }
}

void setup() {
  Serial.begin(9600);//baud rate at which arduino communicates with Laptop/PC
  Wire.begin(); 
  delay(2000);//delay for 2 sec

  // Set the relay on.
  pinMode(Relay_Motors, OUTPUT);
  delay(5);
  digitalWrite(Relay_Motors, LOW);
  delay(5);
}

void loop() //method to run the source code repeatedly
{
  digitalWrite(Relay_Motors, LOW);
  delay(2000);

  for(int i=0;i<256;i++) {
    checkAndSendAction(i);
    delay(50);
  }

  for(int i=0;i<200;i++) {
    checkAndSendAction(255);        
    delay(50);
  }

  for(int i=255;i>0;i=i-2) {
    checkAndSendAction(i);
    delay(50);
  }
  delay(1000);

  digitalWrite(Relay_Motors, HIGH);
  delay(2000);
}
