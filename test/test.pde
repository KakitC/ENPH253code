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

  Serial.begin(9600);
  LCD.clear(); LCD.home();
}


void loop() {
  char serialIn;
  int cursorRow, cursorCol;
  
  
  if(Serial.available()) {
    serialIn = Serial.read();
  }
  
  if (serialIn == '\\') { //If '\', clear LCD and home
    LCD.clear();
    LCD.home();
    cursorRow = 0;
    cursorCol = 0;
  } else {
    if (cursorCol == 15) { //If at end of row, set to start of next
      if (cursorRow == 0) {
        cursorRow = 1;
        cursorCol = 0;
        LCD.setCursor(cursorCol, cursorRow);
        LCD.print(serialIn);
        cursorCol++;
      } 
    } else {
      LCD.setCursor(cursorCol, cursorRow);
      LCD.print(serialIn);
      cursorCol++;
    }
  }
}

