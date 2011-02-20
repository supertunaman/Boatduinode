/* first paddles */
int forward_left = 8;
int forward_right = 9;
int back_right = 10;
int back_left = 11;
int i;

void setup() {
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
  /* go forward for a second */
  power_on(forward_left);
  power_on(forward_right);
  delay(1000);
  power_off(forward_left);
  power_off(forward_right);
  delay(100);
  
  /* turn left for a second */
  power_on(back_left);
  power_on(forward_right);
  delay(1000);
  power_off(back_left);
  power_off(forward_right);
  delay(100);
}
