
/*
SuperShape3D app | Works on Processing 3.0.1
Build over Daniel Shiffman's CodingRainbow tutorial
http://codingrainbow.com | https://youtu.be/RkuBWEkBrZA
Inspired by RezaAli's Supershape's: http://www.syedrezaali.com/#/3d-supershapes/

/////

Used for performing live visuals
Sending sinal through Syphon to mix with other visual content and software
Audio Amplitude changes color cycles
Tab SaveShape has an array to store nice shapes' definitions. that will loop then with the funtion shapeShift(int x);

Visiophone / Rodrigo Carvalho / August 2016

*/

//////////////////////////////////////////////////////////


//Syphon
import codeanticode.syphon.*;
SyphonServer server;

void settings() {
  size(1024,768, P3D);
  PJOGL.profile=1;
}

import peasy.*;
PeasyCam cam;

PVector[][] globe;

// resolução TOTAL
int total = 100;

// ANIM COR
float offset = 0.1;

// supershape parameters
float m1=1;
float m2=1;

float n1a=1;
float n1b=1;
float n1c=1;

float n2a=1;
float n2b=1;
float n2c=1;

float a1=1;
float b1=1;
float a2=1;
float b2=1;

float rota=0;

float anim=1;

void setup() {
  
 // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");

//peasy CAM init
  cam = new PeasyCam(this, 1400);
  
  colorMode(HSB,360,100,100,100);
  globe = new PVector[total+1][total+1];
   
   //Audiostuff      
  input = new AudioIn(this, 0);  //Create an Audio input and grab the 1st channel
  input.start();// start the Audio Input
  rms = new Amplitude(this); // create a new Amplitude analyze
  rms.input(input);  // Patch the input to an volume analyzer
  input.amp(1.0);

//new window for the controls GUI
 cf = new ControlFrame(this, 220, 600, "ControlCenter"); 
 
}

void draw() {

  background(0);
  noStroke();
  lights(); 
  
// autonomous shapeShifting() On/Off
if (shift) animshapeShift(); 
  
//Audio Analise 
float analise = map(rms.analyze(), 0, 0.15, 0.0, gain);
audioIn+= (analise-audioIn)*0.5; //smoothing the audioIn vall
//audioIn=analise;

//println(n2a);
//rotation  
cam.rotateY(0.002);
cam.rotateX(audioIn*0.00005);

if(anim<=50) anim+=(audioIn*0.05);
else anim=0;

// Update Superformula Vars
// #1
m1+=(m1S-m1)*0.1;
n1a+=(n1aS-n1a)*0.1;
n1b+=(n1bS-n1b)*0.1;
n1c+=(n1cS-n1c)*0.1;
// #2
m2+=((m2S)-m2)*0.1;
n2a+=((n2aS)-n2a)*0.1;
n2b+=(n2bS-n2b)*0.1;
n2c+=(n2cS-n2c)*0.1;
 
// Sphere Radius 
float r = 200; 
// Drawing main Sphere
// r1 e r2 are 2D supershapes that intercep around the sphere to create the 3D supershape 
  
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    
    // Formula for the supershape #2  
     float r2= supershape(lat, m2, n2a, n2b,n2c, a2, b2);
    
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, -PI, PI);     
     // Formula for the supershape #2  
    float r1= supershape(lon, m1, n1a, n1b,n1c, a1, b1);    
     //Saving each point+s position on globe[][] 
      float x = r * r1 * cos(lon) * r2 * cos(lat);
      float y = r * r1 * sin(lon) * r2 * cos(lat);
      float z = r * r2 * sin(lat);
      globe[i][j] = new PVector(x, y, z);
    }
  }

//Anim Color
offset+=(audioIn);
//map(audioIn,0,50,0,100)
////////////////////////////////////////////
//Drawing supershape
  for (int i = 0; i < total; i++) {
    //colors
 float hu = map(i, 0, total, 0, total*2);
if( i % 2 == 0){
//fill(map(audioIn,0,50,0,100),40); 
 fill(((hu+offset) % 360)-150, 80, 80,40);
}else{
  fill(((hu+offset) % 360)-150, 100, 100);
}
//Shape
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < total+1; j++) {
      PVector v1 = globe[i][j];
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
 ////////////////////////////////////////////////

//sending image to shypon  
server.sendScreen();

 b1+=(b1S-b1)*0.1;
 a1+=(a1S-a1)*0.1;
 
 b2+=(b2S-b2)*0.1;
 a2+=(a2S-a2)*0.1;
 

}

//Function SUPERSHAPE
// returns the each point position according to the choosen shape's formula 
// http://paulbourke.net/geometry/supershape/
float supershape(float theta, float m, float n1, float n2, float n3, float a, float b){   
  float t1 = abs((1/a)*cos(m * theta / 4));
  t1 = pow(t1, n2);
  float t2 = abs((1/b)*sin(m * theta/4));
  t2 = pow(t2, n3);
  float t3 = t1 + t2;
  float r = pow(t3, - 1 / n1);
 return r; 
}