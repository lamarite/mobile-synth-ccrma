#include <Bounce.h>

bool debug = false;  //is to activate/deactive midi depending on the use



void setup() {
  if (debug) {
  Serial.begin(9600);
  }
}

void loop() {
 int sensorValue = analogRead (A0); //is the FSR, measuring te voltage at analog pin nr. 0 with values from (0-1023) amd (0 and 3.3V) and change the USB type to serial
  if (debug) {
  Serial.println(sensorValue);
  }
  else {
    int  midiCC = 10;
    int midiValue = sensorValue*127/1024;
      usbMIDI.sendControlChange(midiCC, midiValue, 0);
  }
  delay(30); //slowing down the loop
  
}


