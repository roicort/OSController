import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
Sensor sensor;
AccelerometerListener listener;
float ax, ay, az;

import controlP5.*; // import controlP5 library
ControlP5 controlP5; // controlP5 object

import processing.opengl.*;
import oscP5.*;  
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PFont  font;
int varName;

float[] numbers = new float[8];

float[] touchnum1 = new float[1];
float[] touchnum2 = new float[1];

float[] gyronum1 = new float[1];
float[] gyronum2 = new float[1];

float[] auxSend = new float[1];

int col;

//Aqui se configura la IP y el Puerto

String IP = "10.200.3.3";
int Port = 9000;

//***********************************

boolean Touch = false;
boolean Gyro = false;
boolean Slider = false;
boolean Main = false;

boolean BuildSlider = true;
boolean BuildMain = true;

boolean Instructions = false;
boolean More = false;
boolean Acknowledgements = false;

boolean Settings = false;

void setup() {
  
  orientation(PORTRAIT);
 
  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
 
  context = getActivity();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccelerometerListener();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);

    // create a new button with name 'buttonA'

  // and add another 2 buttons
  controlP5.addButton("Slider")
     .setValue(0)
     .setPosition(75,700)
     .setSize(75,75)
     ;
     
  controlP5.addButton("Touch")
     .setValue(0)
     .setPosition(150,700)
     .setSize(75,75)
     ;
  controlP5.addButton("Gyro")
     .setValue(0)
     .setPosition(225,700)
     .setSize(75,75)
     ;    
  controlP5.addButton("Settings")
     .setValue(0)
     .setPosition(300,700)
     .setSize(75,75)
     ;
     
  controlP5.addButton("Main")
     .setValue(0)
     .setPosition(0,700)
     .setSize(75,75)
     ;
  
  
  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress(IP, Port);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
  
 Main = true;
  
}

void draw() { 
  
  if (Main == true){
       background(25, 25, 180);
       textSize(32);
       text("OSC Controller", 10, 90); 
       textSize(20);
       text("MyT Lab - ENES Morelia", 10, 125); 
       textSize(32);
       controlP5.draw();
  }
  
    if (Slider == true){
        background(200,50,0);   
        textSize(32);
        text("Sliders", 10, 90);
        controlP5.draw();

    }
    
    if (Touch == true){

        background(150,28,89); 
        textSize(32);
        text("Touch", 10, 90);
        controlP5.draw();
        rect(40, 200, 400, 400);
        fill(255);
        if ((mouseX > 40) && (mouseX < 440) && (mouseY > 200) && (mouseY < 600)){  
        ellipse(mouseX, mouseY, 10, 10); 
        touchnum1[0]=mouseX/4-10;
        touchnum2[0]=mouseY/4-50;
        send("/touch1",touchnum1);
        send("/touch2",touchnum2);



}
    }
    if (Gyro == true){
      
       background(104,58,200);
       textSize(32);
       text("Gyro", 10, 90); 
       text("X: " + ax + "\nY: " + ay + "\nZ: " + az, 170, 350, width, height);
       ellipse(ax, ay, 10, 10); 
       controlP5.draw();
       gyronum1[0]=ax;
       gyronum2[0]=ay;
       send("/gyro",gyronum1);
       send("/gyro",gyronum2);
    }
    
      if (Instructions == true){
       background(25, 25, 180);
       textSize(32);
       text("OSC Controller", 10, 90); 
       textSize(20);
       text("MyT Lab - ENES Morelia", 10, 125); 
       textSize(32);
       controlP5.draw();
  }
  
    if (More == true){
       background(25, 25, 180);
       textSize(32);
       text("OSC Controller", 10, 90); 
       textSize(20);
       text("MyT Lab - ENES Morelia", 10, 125); 
       textSize(32);
       controlP5.draw();
  }
  
    if (Acknowledgements == true){
       background(25, 25, 180);
       textSize(32);
       text("OSC Controller", 10, 90); 
       textSize(20);
       text("MyT Lab - ENES Morelia", 10, 125); 
       textSize(32);
       controlP5.draw();
    
    
    if (Settings == true){
        background(100,100,100);   
        textSize(32);
        text("Settings", 10, 90); 
        controlP5.draw();

    }
  }
}


class AccelerometerListener implements SensorEventListener {
  public void onSensorChanged(SensorEvent event) {
    ax = event.values[0];
    ay = event.values[1];
    az = event.values[2];    
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
  }
}

public void onResume() {
  super.onResume();
  if (manager != null) {
    manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
  }
}

public void onPause() {
  super.onPause();
  if (manager != null) {
    manager.unregisterListener(listener);
  }
}

void send(String source, float[] numbers){
  OscMessage newMessage = new OscMessage(source);  
  newMessage.add(numbers); 
  oscP5.send(newMessage, myRemoteLocation); 
}



void controlEvent(ControlEvent theEvent) {

  if (theEvent.isController()) { 
    
    
    if (theEvent.getController().getName()=="Touch") {
       Touch = true;
       Gyro = false;
       Slider = false;
        Main = false;
        Instructions = false;
  More = false;
  Acknowledgements = false;
  Settings = false;
  BuildMain = true;
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
      controlP5.remove("Instructions");
    controlP5.remove("More");
    controlP5.remove("Acknowledgements");
    BuildSlider = true;

    }
    
    if (theEvent.getController().getName()=="Gyro") {
      Gyro = true;
      Touch = false;
      Slider = false;
      Instructions = false;
   More = false;
   Acknowledgements = false;
      Main = false;
      Settings = false;
        BuildMain = true;

  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
      controlP5.remove("Instructions");
    controlP5.remove("More");
    controlP5.remove("Acknowledgements");
  BuildSlider = true;

  }

    if (theEvent.getController().getName()=="Slider") {
      Gyro = false;
      Touch = false;
      Slider = true;
      Main = false;
      Instructions = false;
      More = false;
      Acknowledgements = false;
        BuildMain = true;
        Settings = false;
    if (BuildSlider == true){
      controlP5.addSlider("slider1", 0, 100, 0, 20, 200, 410, 20);
      //controlP5.addSlider("slider2", 0, 100, 0, 20, 250, 410, 20);
      //controlP5.addSlider("slider3", 0, 100, 0, 20, 300, 410, 20);
      //controlP5.addSlider("slider4", 0, 100, 0, 20, 350, 410, 20);
      //controlP5.addSlider("slider5", 0, 100, 0, 20, 400, 410, 20);
      //controlP5.addSlider("slider6", 0, 100, 0, 20, 450, 410, 20);
      //controlP5.addSlider("slider7", 0, 100, 0, 20, 500, 410, 20);
      //controlP5.addSlider("slider8", 0, 100, 0, 20, 550, 410, 20);
      controlP5.remove("Instructions");
      controlP5.remove("More");
      controlP5.remove("Acknowledgements");
  BuildSlider=false;
    }
      }
      
      if (theEvent.getController().getName()=="Instructions") {
              Gyro = false;
      Touch = false;
      Slider = false;
      Main = false;
      Instructions = true;
More = false;
Acknowledgements = false;
Settings = false;
        BuildMain = true;

          controlP5.remove("slider1");
           controlP5.remove("slider2");
           controlP5.remove("slider3");
         controlP5.remove("slider4");
       controlP5.remove("slider5");
            controlP5.remove("slider6");
       controlP5.remove("slider7");
          controlP5.remove("slider8");
        controlP5.remove("Instructions");
          controlP5.remove("More");
          controlP5.remove("Acknowledgements");
      }
      if (theEvent.getController().getName()=="More") {
              Gyro = false;
      Touch = false;
      Slider = false;
      Main = false;
      Instructions = false;
     More = true;
     Acknowledgements = false;
     Settings = false;
        BuildMain = true;

          controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
      controlP5.remove("Instructions");
    controlP5.remove("More");
    controlP5.remove("Acknowledgements");
      }
      if (theEvent.getController().getName()=="Acknowledgements") {
              Gyro = false;
      Touch = false;
      Slider = false;
      Main = false;
      Instructions = false;
More = false;
Acknowledgements = true;
Settings = false;
        BuildMain = true;

          controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
      controlP5.remove("Instructions");
    controlP5.remove("More");
    controlP5.remove("Acknowledgements");
      }
      
          if (theEvent.getController().getName()=="Settings") {
              Gyro = false;
      Touch = false;
      Slider = false;
      Main = false;
      Instructions = false;
     More = false;
     Acknowledgements = true;
     Settings = true;
        BuildMain = true;

          controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
      controlP5.remove("Instructions");
    controlP5.remove("More");
    controlP5.remove("Acknowledgements");
      }
      
      if (theEvent.getController().getName()=="slider1"){
      auxSend[0]=theEvent.getController().getValue();
      send("/slider1",auxSend);
    }
    if (theEvent.getController().getName()=="slider2") {
      auxSend[0]=theEvent.getController().getValue();
      send("/slider2",auxSend);
    }
    
        if (theEvent.getController().getName()=="slider3"){
      auxSend[0]=theEvent.getController().getValue();
      send("/slider3",auxSend);
    }
    if (theEvent.getController().getName()=="slider4") {
      auxSend[0]=theEvent.getController().getValue();
      send("/slider4",auxSend);
    }
    
        if (theEvent.getController().getName()=="slider5"){
      auxSend[0]=theEvent.getController().getValue();
      send("/slider5",auxSend);
    }
    if (theEvent.getController().getName()=="slider6") {
      auxSend[0]=theEvent.getController().getValue();
      send("/slider6",auxSend);
    }
    
        if (theEvent.getController().getName()=="slider7"){
      auxSend[0]=theEvent.getController().getValue();
      send("/slider7",auxSend);
    }
    if (theEvent.getController().getName()=="slider8") {
      auxSend[0]=theEvent.getController().getValue();
      send("/slider8",auxSend);
    }
      
    if (theEvent.getController().getName()=="Main") {
       Main = true;
       Touch = false;
       Gyro = false;
       Slider = false;
       Instructions = false;
More = false;
Settings = false;
Acknowledgements = false;

  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
  BuildSlider = true;
  
  if (BuildMain == true){
  
    controlP5.addBang("Instructions")
    .setPosition(175, 300)
      .setSize(120, 50)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
  controlP5.addBang("More")
    .setPosition(175, 400)
      .setSize(120, 50)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
  controlP5.addBang("Acknowledgements")
    .setPosition(175, 500)
      .setSize(120, 50)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
  BuildMain = false;
    }
    }
  }
}
