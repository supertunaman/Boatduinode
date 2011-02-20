/* Sketch to have arduino receive commands via serial to control
 * the boat. 9600 baud is used. Protocol is as follows.
 * 
 * Each command is one byte. There are seven commands:
 * 
 * L  (activates left motor in forward motion)
 * R  (activates right motor in forward motion)
 * l  (activates left motor in reverse motion)
 * r  (activates right motor in reverse motion)
 * p  (stops left motor)
 * s  (stops right motor)
 * S  (stops both motors)
 *
 * Note that pulling the pins LOW activates the motors, and 
 * pulling them HIGH stops them. I have no clue why, so I created 
 * power_on() and power_off() helper functions to make it less 
 * confusing.
 * 
 * love,
 * -tuna
 */

int forward_left = 8;
int forward_right = 9;
int back_right = 10;
int back_left = 11;
int i;

void setup() {
  Serial.begin(9600);
  
  pinMode(forward_left, OUTPUT);
  pinMode(forward_right, OUTPUT);
  pinMode(back_left, OUTPUT);
  pinMode(back_right, OUTPUT);
  
  digitalWrite(forward_left, HIGH);
  digitalWrite(forward_right, HIGH);
  digitalWrite(back_left, HIGH);
  digitalWrite(back_right, HIGH);
}

void power_on(int pin)
{
  digitalWrite(pin, LOW);
}

void power_off(int pin)
{
  digitalWrite(pin, HIGH);
}

void loop()
{
  if (Serial.available() > 0) {
      switch(Serial.read()) {
        case 'L':
          power_off(back_left);
          power_on(forward_left);
          Serial.println("Left motor activated, moving forward");
          break;
        case 'R':
          power_off(back_right);
          power_on(forward_right);
          Serial.println("Right motor activated, moving forward");
          break;
        case 'l':
          power_off(forward_left);
          power_on(back_left);
          Serial.println("Left motor activated, moving in reverse");
          break;
        case 'r':
          power_off(forward_right);
          power_on(back_right);
          Serial.println("Right motor activated, moving in reverse");
          break;
        case 'p':
          power_off(forward_left);
          power_off(back_left);
          Serial.println("Left motor stopped");
          break;
        case 's':
          power_off(forward_right);
          power_off(back_right);
          Serial.println("Right motor stopped");
          break;
        case 'S':
          power_off(forward_left);
          power_off(back_left);
          power_off(forward_right);
          power_off(back_right);
          Serial.println("Both motors stopped");
          break;
      }
  }
}
