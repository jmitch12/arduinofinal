import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//Arduino IDE: File > Example > Firmata > StandardFirmata -----> Upload to your arduino
//Don't close it!

Minim minim;
AudioPlayer hello;
AudioPlayer notouch;
AudioPlayer anything;

import processing.serial.*;
import cc.arduino.*;

Arduino jane;

int ledPin = 9;
int sensorPin = 0;
int sensorPin2 = 1;


void setup() {
  size(1000, 1000);
  background(0);
  smooth();
  ellipseMode(CENTER);
  
  minim = new Minim(this);
  hello = minim.loadFile("hello.mp3");
  hello.play();
  anything = minim.loadFile("Anything With You.mp3");
  notouch = minim.loadFile("donttouch.mp3");
  
//  int rand = random(1,3);
//  minim.loadfile(rand + ".mp3");
  
  println(Arduino.list());

  jane = new Arduino(this, Arduino.list()[2]);

  jane.pinMode(ledPin, Arduino.OUTPUT);
  jane.pinMode(sensorPin, Arduino.INPUT); 
  jane.pinMode(sensorPin2, Arduino.INPUT);
}

void draw() {
  
  int analogValue =  jane.analogRead(sensorPin);
  
  println(analogValue); //print it for testing purposes
   //draw a red circle ellipse the size of the analog value
  
  if (mousePressed == true) 
    { 
            
      jane.digitalWrite(ledPin, Arduino.HIGH);
      delay(1000);
    } else {                           
     jane.digitalWrite(ledPin, Arduino.LOW);     
  }
  
  int analogValue2 =  jane.analogRead(sensorPin2);
  
  if (analogValue2 > 1000){
    anything.play();
    } 
    
    if (analogValue > 100){
//    fill(255,0,0);
//    ellipse(width/2, height/2, analogValue, analogValue);
    textSize(72);
    fill(255, 0, 0);
    text("stop",width/2 - 90,height/2);
    notouch.play();

    
    }
   
}

