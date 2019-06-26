//Measuring Current Using ACS712

const int analogIn = 0; //Connect current sensor with A0 of Arduino
// Scale Factors: 185 mV per Amp for 5A module, 100 mV per Amp for 20A, 66 mV per Amp for 30A
int mVperAmp = 185;
int RawValue= 0;
int ACSoffset = 2500; 
double Voltage = 0; //voltage measuring
double Amps = 0;// Current measuring

void setup() {
  Serial.begin(9600);//baud rate at which arduino communicates with Laptop/PC
  delay(2000);//delay for 2 sec
}

void loop() //method to run the source code repeatedly
{ 
 RawValue = analogRead(analogIn);//reading the value from the analog pin
 Voltage = (RawValue / 1024.0) * 5000; // Gets you mV
 Amps = ((Voltage - ACSoffset) / mVperAmp);
 
 Serial.print("Raw Value = " ); // prints on the serial monitor
 Serial.print(RawValue); //prints the results on the serial monitor
 
 Serial.print("\t mV = "); // shows the voltage measured 
 Serial.print(Voltage,3); // the '3' after voltage allows you to display 3 digits after decimal point
 
 Serial.print("\t Amps = "); // shows the voltage measured 
 Serial.println(Amps,3);// the '3' after voltage allows you to display 3 digits after decimal point
 
 delay(2500);
}
