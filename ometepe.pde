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
  
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF, "images/temp.pdf");

  noLoop();
}

void draw()
{ 
}



