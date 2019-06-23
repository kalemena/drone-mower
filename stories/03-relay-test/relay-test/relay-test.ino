/*Relay Switches*/
#define Relay_Motors 12

void setup() {
  // Set the relay on.
  pinMode(Relay_Motors, OUTPUT);
  delay(5);
  digitalWrite(Relay_Motors, LOW);
  delay(5);
}

void loop() {
  digitalWrite(Relay_Motors, LOW);
  delay(7000);
  digitalWrite(Relay_Motors, HIGH);
  delay(7000);
}
