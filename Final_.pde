/////////////////////////////////////////////
//                                         //
//   KEIJI's CODE FINAL "EARTHCUBE/MYCUBE" //
//                                         //
//  Using peasycam and controlP5 libraries //
//                                         //
/////////////////////////////////////////////



import controlP5.*;
import peasy.*;

//I DO DECLAAARE.... 

ControlP5 kControl;

PeasyCam cam;

public float angle;
public float dustSize = 1.5;
public float bloomColor = 100;
public float bloomColor2 = 175;
public float bloomAlpha = 100;

public int x;
public int y;
public int z;

boolean explosion = false;

float minCam = 250;
float maxCam = 250;  // disables zoom


//INITIALIZE

void setup() {
  size(600, 600, P3D);
  smooth(4);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(minCam);
  cam.setMaximumDistance(maxCam);
  cam.setMouseControlled(false);   // disables mouse viewing 
  noStroke();



  //BUTTON CREATION

  kControl = new ControlP5(this);
  kControl.addButton("bloom")    
    .setValue(0)
      .setPosition(100, 500)
        .setSize(35, 35);

  kControl.addButton("reset")
    .setValue(0)
      .setPosition(450, 500)
        .setSize(35, 35);

  ;
  kControl.setAutoDraw(false);   // Button drawing component
}


void draw() {
  background(255);
  randomSeed(10);
  gui();

  if (explosion) {
    print("explode working");
    dustSize += 1;
    bloomColor = 170;
    bloomColor2 = 100;
    strokeWeight(.5);
    stroke(255);
  }
  if (dustSize >= 50) {
    dustSize = 50;
  }


  // AXES


  rotateZ(angle);
  rotateY(angle);
  rotateX(angle);


  //AUTO ROTATE
  angle += 0.01;



  // CREATION OF CUBE MATRIX

  for (int x = -50; x < 50; x+=10) {
    for (int y = -50; y < 50; y+=10) {
      for (int z = -50; z < 50; z+=10) {


        // LAYERING 
        pushMatrix();
        translate(x, y, z); 
        boxTile();
        popMatrix();


        // BLOOM TILE PLACEMENT 

        pushMatrix();
        translate(x*1.2, y*1.2, z*1.2);   // makes bloom hover over the cube
        bloomTile();
        popMatrix();
      }
    }
  }
}

// EARTH DRAWING

void boxTile() {
  fill(random(110));
  box(random(9));
}

public void controlEvent (ControlEvent theEvent) {


  //BUTTONS AND INPUTS

  if (theEvent.controller() .name() =="bloom") {
    print("bloom working");

    dustSize += 1;
    angle += -.0085;
    bloomColor += 4;
    bloomColor2 += -10;
    bloomAlpha += 1;
    noStroke();
  }
  if (dustSize >= 10) {
    dustSize = 10;
    bloomColor = 175;
    bloomColor2 = 100;
    explosion = !explosion;
  }
  if (theEvent.controller() .name() =="reset") {
    print("reset working");
    dustSize = 1.5;
    bloomColor = 100;
    bloomColor2 = 175;
    bloomAlpha = 100;
    noStroke();
  }
}

//DRAWING BLOOM TILE

void bloomTile() {

  fill(bloomColor, bloomColor2, 0, bloomAlpha);
  box(random(dustSize));
}

// BUTTON ORIENTATION IN 2D PLANE

void gui() {

  camera();
  kControl.draw();
  cam.setMinimumDistance(minCam);
  cam.setMaximumDistance(maxCam);   //Solution to button placement in 2D, not 3D
}

