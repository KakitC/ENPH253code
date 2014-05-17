#include <phys253.h>        		//***** from 253 template file
#include <LiquidCrystal.h>  		//***** from 253 template file
#include <servo253.h>       		//***** from 253 template file 

#define INTERRUPT_0 0

void setup() {
  portMode(0, INPUT) ;      	 	//***** from 253 template file
  portMode(1, INPUT) ;      	   	//***** from 253 template file
  RCServo0.attach(RCServo0Output) ;	//***** from 253 template file
  RCServo1.attach(RCServo1Output) ;	//***** from 253 template file
  RCServo2.attach(RCServo2Output) ;	//***** from 253 template file

  LCD.clear();  LCD.home() ;
  LCD.print("Freq. Counter");
  LCD.setCursor(0,1);
  LCD.print("Initializing...");
  delay(1000);
  LCD.clear();
}

int count = 0;


void loop() {
  double freq;
  long timeStart;
  long timeEnd;
  long timeDiff;

  count = 0;
  timeStart = micros();
  attachInterrupt(INTERRUPT_0, increment, RISING);
  while (count < 1000) {
    delayMicroseconds(1);
  }
  detachInterrupt(INTERRUPT_0);
  timeEnd = micros();
  
  timeDiff = timeEnd - timeStart;
  freq = count*1000000/timeDiff;
  
  LCD.clear(); LCD.home();
  LCD.print("Frequency: ");
  LCD.setCursor(0,1);
  LCD.print(freq);

  delay(100);
}


void increment() {
  count++;
}

