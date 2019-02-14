import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.opengl.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class POSC extends PApplet {


 // import controlP5 library
ControlP5 controlP5; // controlP5 object


  


OscP5 oscP5;
NetAddress myRemoteLocation;

PFont  font;
int varName;
String scene;

float[] touchnum1 = new float[1];
float[] touchnum2 = new float[1];
float[] auxSend = new float[1];

int col;

String IP = "127.0.0.1";
int Port = 2223;

boolean Touch = false;

int red = 255;
int time = 0;
int diameter = 50;
  


public void setup() {
 
  controlP5 = new ControlP5(this);
 

  // description : a button executes after release
  // parameters : name, value (float), x, y, width, height
  //controlP5.addButton("button1", 1, 70, 10, 60, 20);

  // description : a toggle can have two states, true and false
  // where true has the value 1 and false is 0.
  // parameters : name, default value (boolean), x, y, width, height
  //controlP5.addToggle("toggle1", false, 170, 10, 20, 20);

  // description : a slider is either used horizontally or vertically.
  // width is bigger, you get a horizontal slider
  // height is bigger, you get a vertical slider. 
  // parameters : name, minimum, maximum, default value (float), x, y, width, height
  
    // create a new button with name 'buttonA'
  controlP5.addButton("Main")
     .setValue(0)
     .setPosition(0,700)
     .setSize(75,75)
     ;
  
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
  controlP5.addButton("Buttons")
     .setValue(0)
     .setPosition(225,700)
     .setSize(75,75)
     ;
     
  controlP5.addButton("Settings")
     .setValue(0)
     .setPosition(300,700)
     .setSize(75,75)
     ;

  
  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress(IP, Port);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
  sceneSelect("Main");
}

public void sceneSelect(String scene){
  
  if (scene=="Main"){
  textSize(32);
  background(0, 149, 182);
  text("OSC Controller", 10, 90); 
    textSize(20);
  text("MyT Lab - ENES Morelia", 10, 125); 
    textSize(32);
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
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
  println("Main");
  }
  
      if (scene == "More"){
 background(100,0,100);
  text("More", 10, 90); 
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");

  textSize(16);
  String s = "Proyecto OSCcontroller para Mario Duarte, investigador Doctoral. \n http://duartemario.com";
  text(s, 200, 200, 200, 200);  // Text wraps within text box
  println("More");
  }
      if (scene == "Acknowledgements"){
 background(200,0,0);
  text("Acknowledgements", 10, 90); 
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");
  textSize(16);
  String s = "Thanks to the creators of OSCP5 & ControlP5. \nDevelopped by Rodrigo Cortez\nENES Morelia 2018";
  text(s, 190, 400, 200, 200);  // Text wraps within text box
  println("Acknowledgements");
  }
  
 if (scene == "Instructions"){
 background(200,20,49);
  text("Instructions", 10, 90); 
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");
  textSize(16);
  String s = "Configura en Settings la IP y el Puerto del Cliente. \n Recuerda que debe ser el mismo puerto y la IP utilizada en el Servidor ";
  text(s, 200, 200, 200, 200);  // Text wraps within text box
  println("Instructions");
  }
    
  if (scene == "Slider"){
  background(200,30,70);   
    textSize(32);
  text("Sliders", 10, 90); 
  controlP5.addSlider("slider1", 0, 100, 0, 20, 200, 410, 20);
  controlP5.addSlider("slider2", 0, 100, 0, 20, 250, 410, 20);
  controlP5.addSlider("slider3", 0, 100, 0, 20, 300, 410, 20);
  controlP5.addSlider("slider4", 0, 100, 0, 20, 350, 410, 20);
  controlP5.addSlider("slider5", 0, 100, 0, 20, 400, 410, 20);
  controlP5.addSlider("slider6", 0, 100, 0, 20, 450, 410, 20);
  controlP5.addSlider("slider7", 0, 100, 0, 20, 500, 410, 20);
  controlP5.addSlider("slider8", 0, 100, 0, 20, 550, 410, 20);
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
            controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");
  println("Slider");
  }
  
  if (scene == "Buttons"){
      background(200,50,80);   
    textSize(32);
  text("Buttons", 10, 90); 
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");
  
  
  controlP5.addToggle("toggle1")
     .setPosition(160,250)
     .setSize(50,20)
     ;
    controlP5.addToggle("toggle2")
     .setPosition(160,325)
     .setSize(50,20)
     ;
       controlP5.addToggle("toggle3")
     .setPosition(160,400)
     .setSize(50,20)
     ;
       controlP5.addToggle("toggle4")
     .setPosition(160,475)
     .setSize(50,20)
     ;
     
     
       controlP5.addToggle("toggle5")
     .setPosition(260,250)
     .setSize(50,20)
     ;
    controlP5.addToggle("toggle6")
     .setPosition(260,325)
     .setSize(50,20)
     ;
       controlP5.addToggle("toggle7")
     .setPosition(260,400)
     .setSize(50,20)
     ;
       controlP5.addToggle("toggle8")
     .setPosition(260,475)
     .setSize(50,20)
     ;
  
  println("Buttons");
  }
  
  if (scene == "Touch"){
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
  controlP5.remove("More");
  controlP5.remove("Acknowledgements");
  controlP5.remove("Instructions");
  println("Touch");
  }

  if (scene == "Settings"){
      background(100);   
        textSize(32);
      text("Settings", 10, 90); 
  controlP5.remove("slider1");
  controlP5.remove("slider2");
  controlP5.remove("slider3");
  controlP5.remove("slider4");
  controlP5.remove("slider5");
  controlP5.remove("slider6");
  controlP5.remove("slider7");
  controlP5.remove("slider8");
       controlP5.remove("toggle1");
     controlP5.remove("toggle2");
     controlP5.remove("toggle3");
     controlP5.remove("toggle4");
                 controlP5.remove("toggle5");
     controlP5.remove("toggle6");
     controlP5.remove("toggle7");
     controlP5.remove("toggle8");
      controlP5.remove("More");
      controlP5.remove("Acknowledgements");
      controlP5.remove("Instructions");
      text(IP, 10, 500); 
      text(Port, 10, 550); 

  PFont font = createFont("arial", 20);

  controlP5.addTextfield("IP")
    .setPosition(20, 200)
      .setSize(200, 40)
        .setFont(font)
            .setColorBackground(color(150))
            .setColorValue(color(255))
            .setColorForeground(color(155))
              ;
 
  controlP5.addTextfield("Port")
    .setPosition(20, 270)
      .setSize(200, 40)
        .setFont(font)
            .setColorBackground(color(150))
            .setColorValue(color(255))
            .setColorForeground(color(155))
            ;
 
  controlP5.addBang("Save")
    .setPosition(240, 270)
      .setSize(80, 40)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
          ;
          
          
       /* .setColorValue(color(255))
            .setColorActive(color(155))
              .setColorForeground(color(155))
                .setColorValue(color(255))*/
  }
}


public void draw() { 
  
    if (Touch == true){
        background(150,28,89); 
        text("Touch", 10, 90);

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
}

public void send(String source, float[] numbers){
  OscMessage newMessage = new OscMessage(source);  
  newMessage.add(numbers); 
  oscP5.send(newMessage, myRemoteLocation); 
}

public void controlEvent(ControlEvent theEvent) {

  if (theEvent.isController()) { 

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
      sceneSelect("Main");

      Touch = false;
    }
    
    if (theEvent.getController().getName()=="Slider") {
      sceneSelect("Slider");

      Touch = false;
    }
    if (theEvent.getController().getName()=="Touch") {
       sceneSelect("Touch");
         controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");
       Touch = true;

    }
    if (theEvent.getController().getName()=="Buttons") {
      sceneSelect("Buttons");
  controlP5.remove("IP");
  controlP5.remove("Port");
  controlP5.remove("Save");

      Touch = false;
    }
    if (theEvent.getController().getName()=="Settings") {
     sceneSelect("Settings");

      Touch = false;
    }
     if (theEvent.getController().getName()=="Save") {
         IP = controlP5.get(Textfield.class,"IP").getText();
         Port = Integer.parseInt(controlP5.get(Textfield.class,"Port").getText());
     println("Saved");
     controlP5.remove("IP");
     controlP5.remove("Port");
       oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress(IP, Port);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
     sceneSelect("Settings");
    }
     if (theEvent.getController().getName()=="More") {
      sceneSelect("More");

      Touch = false;
    }
         if (theEvent.getController().getName()=="Acknowledgements") {
      sceneSelect("Acknowledgements");

      Touch = false;
    }
      if (theEvent.getController().getName()=="Instructions") {
      sceneSelect("Instructions");

      Touch = false;
    }
          if (theEvent.getController().getName()=="toggle1") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button1",auxSend);
    }
              if (theEvent.getController().getName()=="toggle2") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button2",auxSend);
    }
              if (theEvent.getController().getName()=="toggle3") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button3",auxSend);
    }
              if (theEvent.getController().getName()=="toggle4") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button4",auxSend);
    }
            if (theEvent.getController().getName()=="toggle5") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button5",auxSend);
    }
              if (theEvent.getController().getName()=="toggle6") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button6",auxSend);
    }
              if (theEvent.getController().getName()=="toggle7") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button7",auxSend);
    }
              if (theEvent.getController().getName()=="toggle8") {
           auxSend[0]=theEvent.getController().getValue();
           send("/button8",auxSend);
    }
  }
  }

public void varName(int _varName) {
  varName = _varName;
}
  public void settings() {  size(480, 800,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "POSC" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
