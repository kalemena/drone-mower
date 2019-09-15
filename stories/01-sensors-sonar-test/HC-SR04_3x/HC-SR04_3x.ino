// Anything over 400 cm (23200 us pulse) is "out of range"
const unsigned int MAX_DIST = 23200;

typedef struct {
    int pinTrig;
    int pinEcho;
} SonarSetting;

SonarSetting sonarSensors[3] = {
  { 7, 8 },
  { 9, 10 },
  { 11, 12 }
};

void setupSonar(SonarSetting sonarSetting) {
  // The Trigger pin will tell the sensor to range find
  pinMode(sonarSetting.pinTrig, OUTPUT);
  digitalWrite(sonarSetting.pinTrig, LOW);
}

void setup() {

  for(int i=0; i<3; i++) {
    setupSonar(sonarSensors[i]);
  }

  // We'll use the serial monitor to view the sensor output
  Serial.begin(9600);
}

int sensSonar(SonarSetting sonarSetting) {
  unsigned long t1;
  unsigned long t2;
  unsigned long pulse_width;
  float cm;
  
  // Hold the trigger pin high for at least 10 us
  digitalWrite(sonarSetting.pinTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(sonarSetting.pinTrig, LOW);

  // Wait for pulse on echo pin
  while ( digitalRead(sonarSetting.pinEcho) == 0 );

  // Measure how long the echo pin was held high (pulse width)
  // Note: the micros() counter will overflow after ~70 min
  t1 = micros();
  while ( digitalRead(sonarSetting.pinEcho) == 1);
  t2 = micros();
  pulse_width = t2 - t1;

  // Calculate distance in centimeters. The constants
  // are found in the datasheet, and calculated from the assumed speed
  // of sound in air at sea level (~340 m/s).
  cm = pulse_width / 58.0;

  // Print out results
  if ( pulse_width > MAX_DIST ) {
    return -1;
  } else {
    return cm;
  }
}

void loop() {

  for(int i=0; i<3; i++) {
    int dist = sensSonar(sonarSensors[i]);
    Serial.print("Dist");
    Serial.print(i);
    Serial.print("=");
    Serial.print(dist);
    Serial.print(" cm \n");
  }
  
  // Wait at least 60ms before next measurement
  delay(100);
}
