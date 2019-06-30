#define enA 9
#define in1 4
#define in2 5

#define enB 8
#define in3 6
#define in4 7

enum Direction { CW = 1, CCW = 0 };

struct Motor {
    int speed;
    Direction dir;
};

struct Motor motorLeft = { 80, CW };
struct Motor motorRight = { 80, CW };

void setMotor1(int speed, Direction dir) {
  if(dir == CW) {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
  } else {
    digitalWrite(in1, HIGH);
    digitalWrite(in2, LOW);
  }

  analogWrite(enA, speed);
}

void setMotor2(int speed, Direction dir) {
  if(dir == CW) {
    digitalWrite(in3, LOW);
    digitalWrite(in4, HIGH);
  } else {
    digitalWrite(in3, HIGH);
    digitalWrite(in4, LOW);
  }

  analogWrite(enB, speed);
}

void setup() {
  Serial.begin(9600);
  
  pinMode(enA, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);

  pinMode(enB, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);

  setMotor1(255, CW);
  setMotor2(255, CW);
}

void loop() {
  Serial.println("Dir = CW");
  setMotor1(255, CW);
  setMotor2(255, CW);
  delay(5000);
  Serial.println("Dir = CCW");
  setMotor1(255, CCW);
  setMotor2(255, CCW);
  delay(5000);
}
