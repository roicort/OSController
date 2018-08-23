//Android Processing OSC Controller
//Developed by Rodrigo Cortez
//ENES Morelia 2018

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

float[] touchnum1 = new float[1];
float[] touchnum2 = new float[1];

float[] gyronum1 = new float[1];
float[] gyronum2 = new float[1];

float[] slider1 = new float[1];
float[] slider2 = new float[1];
float[] slider3 = new float[1];
float[] slider4 = new float[1];
float[] slider5 = new float[1];
float[] slider6 = new float[1];
float[] slider7 = new float[1];
float[] slider8 = new float[1];

float[] toggle1 = new float[1];
float[] toggle2 = new float[1];
float[] toggle3 = new float[1];
float[] toggle4 = new float[1];
float[] toggle5 = new float[1];
float[] toggle6 = new float[1];
float[] toggle7 = new float[1];
float[] toggle8 = new float[1];

float[] window = new float[1];

int col;

//Aqui se configura la IP y el Puerto

String IP = "192.168.1.192";
int Port = 8000;

//***********************************

boolean Home = false;
boolean Sliders = false;
boolean Touch = false;
boolean Gyro = false;
boolean Buttons = false;
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

  controlP5.addButton("Sliders")
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
     
  controlP5.addButton("Buttons")
     .setValue(0)
     .setPosition(300,700)
     .setSize(75,75)
     ;    
     
  controlP5.addButton("Home")
     .setValue(0)
     .setPosition(0,700)
     .setSize(75,75)
     ;
     
     
    controlP5.addSlider("S1")
     .setPosition(50,200)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S2")
     .setPosition(50,250)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S3")
     .setPosition(50,300)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S4")
     .setPosition(50,350)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S5")
     .setPosition(50,400)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S6")
     .setPosition(50,450)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S7")
     .setPosition(50,500)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
    controlP5.addSlider("S8")
     .setPosition(50,550)
     .setSize(380,40)
     .setRange(0,100)
     .hide()
     ;
     
     
     
     
     
    controlP5.addToggle("T1")
     .setPosition(160,250)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T2")
     .setPosition(160,325)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T3")
     .setPosition(160,400)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T4")
     .setPosition(160,475)
     .setSize(50,20)
     .hide()
     ;
     
    controlP5.addToggle("T5")
     .setPosition(260,250)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T6")
     .setPosition(260,325)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T7")
     .setPosition(260,400)
     .setSize(50,20)
     .hide()
     ;
    controlP5.addToggle("T8")
     .setPosition(260,475)
     .setSize(50,20)
     .hide()
     ;
     
  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress(IP, Port);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
  
}

void draw() { 
  
  if (Home == true){
       background(0, 149, 182);
       textSize(32);
       text("OSC Controller", 10, 90); 
       textSize(20);
       text("MyT Lab - ENES Morelia", 10, 125); 
       textSize(32);
       controlP5.draw();
  }
  
    if (Sliders == true){
        background(214, 0, 57);  
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
       text("X: " + ax + "\nY: " + ay, 170, 350, width, height);
       controlP5.draw();
       gyronum1[0]=ax;
       gyronum2[0]=ay;
       send("/gyro1",gyronum1);
       send("/gyro2",gyronum2);
    }

    if (Buttons == true){
        background(200,50,0);    
        textSize(32);
        text("Buttons", 10, 90);
        controlP5.draw();
    }
    
    if (Settings == true){
        background(200,50,0);   
        textSize(32);
        text("Settings", 10, 90);
        controlP5.draw();

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

void hideSliders(){
  
    controlP5.getController("S1").hide();
    controlP5.getController("S2").hide();
    controlP5.getController("S3").hide();
    controlP5.getController("S4").hide();
    controlP5.getController("S5").hide();
    controlP5.getController("S6").hide();
    controlP5.getController("S7").hide();
    controlP5.getController("S8").hide();  
 
}

void hideToggle(){
  
    controlP5.getController("T1").hide();
    controlP5.getController("T2").hide();
    controlP5.getController("T3").hide();
    controlP5.getController("T4").hide();
    controlP5.getController("T5").hide();
    controlP5.getController("T6").hide();
    controlP5.getController("T7").hide();
    controlP5.getController("T8").hide();  
 
}


void controlEvent(ControlEvent theEvent) {

  if (theEvent.isController()) { 
    
  if ((theEvent.getController().getName()=="Home") && (Home==false)) {
    Home=true;
    Sliders=false;
    Touch=false;
    Gyro=false;
    Buttons=false;
    Settings=false;  
    hideSliders();
    hideToggle();
    window[0]=1;
    send("/window",window);
  }
    
  if ((theEvent.getController().getName()=="Sliders") && (Sliders==false)) {
    Home=false;
    Sliders=true;
    Touch=false;
    Gyro=false;
    Buttons=false;
    Settings=false;
    
    controlP5.getController("S1").show();
    controlP5.getController("S2").show();
    controlP5.getController("S3").show();
    controlP5.getController("S4").show();
    controlP5.getController("S5").show();
    controlP5.getController("S6").show();
    controlP5.getController("S7").show();
    controlP5.getController("S8").show();  
    hideToggle();
    window[0]=2;
    send("/window",window);
 

    
  }
  if ((theEvent.getController().getName()=="Touch") && (Touch==false)) {
    Home=false;
    Sliders=false;
    Touch=true;
    Gyro=false;
    Buttons=false;
    Settings=false;
    hideSliders();
    hideToggle();
        window[0]=3;
    send("/window",window);
  }
  if ((theEvent.getController().getName()=="Gyro") && (Gyro==false)) {
    Home=false;
    Sliders=false;
    Touch=false;
    Gyro=true;
    Buttons=false;
    Settings=false;
    hideSliders();
    hideToggle();
        window[0]=4;
    send("/window",window);
  }
  if ((theEvent.getController().getName()=="Buttons") && (Buttons==false)) {
    Home=false;
    Sliders=false;
    Touch=false;
    Gyro=false;
    Buttons=true;
    Settings=false;
    hideSliders();
    window[0]=5;
    send("/window",window);
        
    controlP5.getController("T1").show();
    controlP5.getController("T2").show();
    controlP5.getController("T3").show();
    controlP5.getController("T4").show();
    controlP5.getController("T5").show();
    controlP5.getController("T6").show();
    controlP5.getController("T7").show();
    controlP5.getController("T8").show();    
  } 
  if (theEvent.getController().getName()=="S1"){
      slider1[0]=theEvent.getController().getValue();
      send("/slider1",slider1);
    }
    if (theEvent.getController().getName()=="S2") {
      slider2[0]=theEvent.getController().getValue();
      send("/slider2",slider2);
    }
    
        if (theEvent.getController().getName()=="S3"){
      slider3[0]=theEvent.getController().getValue();
      send("/slider3",slider3);
    }
    if (theEvent.getController().getName()=="S4") {
      slider4[0]=theEvent.getController().getValue();
      send("/slider4",slider4);
    }
    
        if (theEvent.getController().getName()=="S5"){
      slider5[0]=theEvent.getController().getValue();
      send("/slider5",slider5);
    }
    if (theEvent.getController().getName()=="S6") {
      slider6[0]=theEvent.getController().getValue();
      send("/slider6",slider6);
    }
    
        if (theEvent.getController().getName()=="S7"){
      slider7[0]=theEvent.getController().getValue();
      send("/slider7",slider7);
    }
    if (theEvent.getController().getName()=="S8") {
      slider8[0]=theEvent.getController().getValue();
      send("/slider8",slider8);
    }
    
      if (theEvent.getController().getName()=="T1") {
           toggle1[0]=theEvent.getController().getValue();
           send("/button1",toggle1);
    }
              if (theEvent.getController().getName()=="T2") {
           toggle2[0]=theEvent.getController().getValue();
           send("/button2",toggle2);
    }
              if (theEvent.getController().getName()=="T3") {
           toggle3[0]=theEvent.getController().getValue();
           send("/button3",toggle3);
    }
              if (theEvent.getController().getName()=="T4") {
           toggle4[0]=theEvent.getController().getValue();
           send("/button4",toggle4);
    }
            if (theEvent.getController().getName()=="T5") {
           toggle5[0]=theEvent.getController().getValue();
           send("/button5",toggle5);
    }
              if (theEvent.getController().getName()=="T6") {
           toggle6[0]=theEvent.getController().getValue();
           send("/button6",toggle6);
    }
              if (theEvent.getController().getName()=="T7") {
           toggle7[0]=theEvent.getController().getValue();
           send("/button7",toggle7);
    }
              if (theEvent.getController().getName()=="T8") {
           toggle8[0]=theEvent.getController().getValue();
           send("/button8",toggle8);
    }
  }
}

    


public void varName(int _varName) {
  varName = _varName;
}
