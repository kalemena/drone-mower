
#define SENSOR_PIN_DIGITAL 12
#define SENSOR_PIN_ANALOG A0

// lowest and highest sensor readings:
const int sensorMin = 0;     // sensor minimum
const int sensorMax = 1024;  // sensor maximum

void setup() {
  Serial.begin(9600);  
}
void loop() {
  int sensorReading = analogRead(SENSOR_PIN_ANALOG);
  int range = map(sensorReading, sensorMin, sensorMax, 0, 3);
  
  // range value:
  switch (range) {
   case 0:    // Sensor getting wet
      Serial.println("Flood");
      break;
   case 1:    // Sensor getting wet
      Serial.println("Rain Warning");
      break;
   case 2:    // Sensor dry - To shut this up delete the " Serial.println("Not Raining"); " below.
      Serial.println("Not Raining");
      break;
  }
  delay(1000);
}
