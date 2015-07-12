// ometepe circle generator
// by martin breuer - gedankensuppe.de
// GPLv3 

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

import processing.pdf.*;
PGraphicsPDF pdf;

private ControlP5 gui;
ControlFrame guiWindow;

Origin origin = new Origin();

// globals
float y = 100;

void setup()
{
  size(426, 600);
  background(255);  
  stroke(0);     
  smooth();
  
  gui = new ControlP5(this);
  guiWindow = addControlFrame("engine", 180,275);
  
  println(" ");
  println("*** ometepe circle generator ***");
  println("*** v0.3 GPLv3 ***");
  
  noLoop();
}

void draw()
{ 
  
}



