import processing.sound.*;
import controlP5.*;

//CONTROL Stuff
//Control Functions
ControlFrame cf;
////////////////////////////////
//VARS for the Controls. to manage Superformula
float m1S=0.0;
float n1aS=0.0;
float n1bS=0.0;
float n1cS=0.0;

float m2S=0.0;
float n2aS=0.0;
float n2bS=0.0;
float n2cS=0.0;

float a1S;
float b1S;
float a2S;
float b2S;

float gain=10;

//Audio Functions
AudioIn input;
Amplitude rms;
FFT fft;

//Audio Vars
int scale=1;
//var that stores amplitude
float audioIn=0.0;
// Define how many FFT bands we want
int bands = 128;
// Create a smoothing vector
float[] sum = new float[bands];
// Create a smoothing factor
float smooth_factor = 0.2;


/////////////////////////


class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);
      
   //shape #1 parameters
    cp5.addSlider("M1")
       .plugTo(parent, "m1S")
       .setRange(0.1, 20)
       .setValue(1)
       .setPosition(20, 20)
       .setSize(160, 20);
       
        cp5.addSlider("N1A")
       .plugTo(parent, "n1aS")
       .setRange(0, 30)
       .setValue(1)
       .setPosition(20, 50)
       .setSize(160, 20);
       
        cp5.addSlider("N1B")
       .plugTo(parent, "n1bS")
       .setRange(-50, 50)
       .setValue(1)
       .setPosition(20, 80)
       .setSize(160, 20);
       
        cp5.addSlider("N1C")
       .plugTo(parent, "n1cS")
       .setRange(-50, 50)
       .setValue(1)
       .setPosition(20, 110)
       .setSize(160, 20);
       
          //shape #2 parameters
        cp5.addSlider("M2")
       .plugTo(parent, "m2S")
       .setRange(0.1, 20)
       .setValue(1)
       .setPosition(20, 160)
       .setSize(160, 20);
       
        cp5.addSlider("N2A")
       .plugTo(parent, "n2aS")
       .setRange(0, 30)
       .setValue(1)
       .setPosition(20, 190)
       .setSize(160, 20);
       
        cp5.addSlider("N2B")
       .plugTo(parent, "n2bS")
       .setRange(-50, 50)
       .setValue(1)
       .setPosition(20, 220)
       .setSize(160, 20);
       
        cp5.addSlider("N2C")
       .plugTo(parent, "n2cS")
       .setRange(-50, 50)
       .setValue(1)
       .setPosition(20, 250)
       .setSize(160, 20);
       
       cp5.addSlider("A1")
       .plugTo(parent, "a1S")
       .setRange(0.1, 5.)
       .setValue(1)
       .setPosition(20, 300)
       .setSize(160, 20);
       
        cp5.addSlider("B1")
       .plugTo(parent, "b1S")
       .setRange(0.1, 5.)
       .setValue(1)
       .setPosition(20, 330)
       .setSize(160, 20);
       
         cp5.addSlider("A2")
       .plugTo(parent, "a2S")
       .setRange(0.1, 5.)
       .setValue(1)
       .setPosition(20, 360)
       .setSize(160, 20);
       
        cp5.addSlider("B2")
       .plugTo(parent, "b2S")
       .setRange(0.1, 5.)
       .setValue(1)
       .setPosition(20, 390)
       .setSize(160, 20);
      
      
        cp5.addSlider("GAIN")
       .plugTo(parent, "gain")
       .setRange(0.1, 100.)
       .setValue(10)
       .setPosition(20, 440)
       .setSize(160, 20);
       
         // create a toggle
      cp5.addToggle("SHAPE SHIFT")
      .plugTo(parent, "shift")
     .setPosition(20,470)
     .setSize(160,20)
     ;
      
  }

  void draw() {
    background(10);
   
    if (keyPressed) {
    if (key == 's' ) cp5.saveProperties(("hello.properties"));
    if (key == 'l' ) cp5.loadProperties(("hello.properties"));
       
    if (key == '1' ) {shapeShift(0);}
    if (key == '2' ) {shapeShift(1);}
    if (key == '3' ) {shapeShift(2);}
    if (key == '4' ) {shapeShift(3);}
    if (key == '5' ) {shapeShift(4);}
    
}

  }
}