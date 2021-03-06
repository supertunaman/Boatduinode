/* Copyright (C) 2011 by ath (@supertunaman)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE. */

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
