import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 gui;
ControlFrame guiWindow;

// globals
float y = 100;

void setup()
{
  size(426, 600);
  background(255);  
  stroke(0);     
  frameRate(30);
  smooth();
  
  gui = new ControlP5(this);
  guiWindow = addControlFrame("engine", 180,275);
}

void draw()
{
  //background(255);  
}



