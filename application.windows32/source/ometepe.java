import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Frame; 
import java.awt.BorderLayout; 
import controlP5.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ometepe extends PApplet {

// ometepe circle generator
// by martin breuer - gedankensuppe.de
// GPLv3 






PGraphicsPDF pdf;

private ControlP5 gui;
ControlFrame guiWindow;

Origin origin = new Origin();

// globals
float y = 100;

public void setup()
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

public void draw()
{ 
  
}



public void exPdf()
{
  String path = "images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".pdf";
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF, path);
  
  //record pdf and redraw geometry
  beginRecord(pdf);
  origin.show();
  endRecord(); 
  
  println("success saving: "+path);
  println("---");
}

public void exPng()
{
  String path = "images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png";
  save(path);
  println("success saving: "+path);
  println("---");
}

public void exBatch()
{
  Controller it = guiWindow.gui.getController("iterations");
  int iterations = (int)it.getValue();   
  
  for(int i = 0;i<iterations;i++)
  {
    String path = "images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+"_"+millis()+".pdf";
    pdf = (PGraphicsPDF) createGraphics(width, height, PDF, path);

    origin.generate();
    beginRecord(pdf);
    origin.show();
    endRecord();
    
    println(i+1+"/"+iterations+" iterations generated: "+path);
    println("---");
   
    int wait = 100;
    int time = millis();//store the current time

    println(wait+" millis delay");
    while(millis()-time < wait){}
  }
  println("AUTOPILOT COMPLETE");
  println("---");
}
public class Origin
{
    PVector[] center;
    ArrayList<PVector> node = new ArrayList<PVector>();
    
    float[] dist;
    float[] angle;
    
    int[] fib = {2, 3, 6};
    float[] offset = {PI/2, PI, PI+PI/2, 2*PI};
    
    float alpha;
    int sColor, eColor, number;
    
    public void create()
    {
      Controller sc = guiWindow.gui.getController("start color");
      sColor = PApplet.parseInt(map(sc.getValue(), 0, 100, 0, 255));
      
      Controller ec = guiWindow.gui.getController("end color");
      eColor = PApplet.parseInt(map(ec.getValue(), 0, 100, 0, 255));
      
      Controller al = guiWindow.gui.getController("alpha");
      alpha = PApplet.parseInt(map(al.getValue(), 0, 1, 0, 255));
       
      Controller nu = guiWindow.gui.getController("number");      
      number = (int)nu.getValue();
      
      dist = new float[number];
      angle = new float[number];
      
      Controller s = guiWindow.gui.getController("size");      
      dist[0] = s.getValue()*4;
      
      Controller a = guiWindow.gui.getController("angle");
      angle[0] = radians(a.getValue())+PI/2;      
                  
      populate();
    }
    
    public void generate()
    {      
      ControllerGroup autoSC = guiWindow.gui.getGroup("randomize"); 
    
      if(autoSC.getArrayValue()[4] == 1)
      {
        sColor = (int)random(0,255);
        println("rnd start color "+sColor);
      }
      else
      {
        Controller sc = guiWindow.gui.getController("start color");
        sColor = PApplet.parseInt(map(sc.getValue(), 0, 100, 0, 255));
      }
      
      if(autoSC.getArrayValue()[5] == 1)
      {
        eColor = (int)random(0,255);
        println("rnd end color "+eColor);
      }
      else
      {
        Controller ec = guiWindow.gui.getController("end color");
        eColor = PApplet.parseInt(map(ec.getValue(), 0, 100, 0, 255));
      }
      
      if(autoSC.getArrayValue()[3] == 1)
      {
        alpha = (int)random(0,255);
        println("rnd alpha "+alpha);
      }
      else
      {
        Controller al = guiWindow.gui.getController("alpha");
        alpha = PApplet.parseInt(map(al.getValue(), 0, 1, 0, 255));
      }
      
      if(autoSC.getArrayValue()[1] == 1)
      {
        number = (int)random(2,20);
        println("rnd number "+number);
      }
      else
      {
        Controller nu = guiWindow.gui.getController("number");      
        number = (int)nu.getValue();
      }
      
      dist = new float[number];
      angle = new float[number];
            
      if(autoSC.getArrayValue()[0] == 1)
      {
        dist[0] = random(1,80)*4;
        println("rnd size "+dist[0]);
      }
      else
      {
        Controller s = guiWindow.gui.getController("size");      
        dist[0] = s.getValue()*4;
      }
      
      if(autoSC.getArrayValue()[2] == 1)
      {
        angle[0] = random(0,360);
        println("rnd angle "+angle[0]);
      }
      else
      {
        Controller a = guiWindow.gui.getController("angle");
        angle[0] = radians(a.getValue())+PI/2;      
      }
      
      populate();
    }
    
    public void populate()
    {
      center = new PVector[number];
      center[0] = new PVector(random(width),random(height));
      
      node.clear();
      
      node.add(new PVector(center[0].x + cos(angle[0])*dist[0] , center[0].y + sin(angle[0])*dist[0]));
      node.add(new PVector(center[0].x + cos(angle[0]+PI/2)*dist[0] , center[0].y + sin(angle[0]+PI/2)*dist[0]));
      node.add(new PVector(center[0].x + cos(angle[0]+PI)*dist[0] , center[0].y + sin(angle[0]+PI)*dist[0]));
      node.add(new PVector(center[0].x + cos(angle[0]+PI+PI/2)*dist[0] , center[0].y + sin(angle[0]+PI+PI/2)*dist[0]));
      
      for(int i = 1; i<number;i++)
      {
        int rnd = (int)random(0,node.size());
        center[i] = new PVector(node.get(rnd).x , node.get(rnd).y);
                
        dist[i]=dist[0]/fib[(int)random(0,fib.length)];
        angle[i]=angle[0]+offset[(int)random(0,3)];
        
        node.add(new PVector(center[i].x + cos(angle[i])*dist[i] , center[i].y + sin(angle[i])*dist[i]));
        node.add(new PVector(center[i].x + cos(angle[i]+PI/2)*dist[i] , center[i].y + sin(angle[i]+PI/2)*dist[i]));
        node.add(new PVector(center[i].x + cos(angle[i]+PI)*dist[i] , center[i].y + sin(angle[i]+PI)*dist[i]));
        node.add(new PVector(center[i].x + cos(angle[i]+PI+PI/2)*dist[i] , center[i].y + sin(angle[i]+PI+PI/2)*dist[i]));
        
        node.remove(rnd);

      }
      println(center.length+" nodes");    
    }
    
    public void show()
    {
      //render the final image
      background(255);
      strokeWeight(0);
      strokeCap(SQUARE);
      //noStroke();

      for(int i=0;i<center.length;i++)
      {
        beginShape(TRIANGLE_STRIP);
        for(float step=0; step<=TWO_PI; step+=TWO_PI/360)
        { 
          stroke(lerpColor(sColor, eColor, step/TWO_PI),alpha);
          fill(lerpColor(sColor, eColor, step/TWO_PI),alpha);

          vertex(center[i].x,center[i].y);
          vertex(center[i].x+cos(step+angle[i])*dist[i],center[i].y+sin(step+angle[i])*dist[i]);
        } 
        endShape();
      }
      
      redraw();

    }
    
    public void debug()
    {
      //show how the image is constructed
      strokeCap(ROUND);
      background(255);
      stroke(190, 190, 190, alpha);
      strokeWeight(1);
      fill(230, alpha); 
      ellipseMode(RADIUS);
      
      for(int i = 0; i<center.length;i++)
      {  
        ellipse(center[i].x, center[i].y, dist[i], dist[i]);  
      }  

      stroke(150, 150, 150, alpha);
      strokeWeight(1);
     
      for(int i = 0; i<center.length;i++)
      {
        line(center[i].x,center[i].y,node.get(i*3).x,node.get(i*3).y);
      }
      
      stroke(0, 0, 0);
      strokeWeight(4);
      
      for(int i = 0; i<center.length;i++)
      {
        point(center[i].x,center[i].y);
      }

      stroke(204, 102, 0);
      
      for(int i = 0; i<node.size();i++)
      {
        point(node.get(i).x,node.get(i).y);
      }
      
      redraw();
  
    }
}
public ControlFrame addControlFrame(String theName, int theWidth, int theHeight) 
{
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet 
{

  int w, h;
  boolean debug = false;
  
  public void setup() 
  {
    size(w, h);
    frameRate(30);
    gui = new ControlP5(this);
    
    gui.getTab("default")
      .activateEvent(true)
      .setLabel("settings")
      .setId(1);
  
    //Settings
    
    gui.addButton("generate")
      .setPosition(10, 30)
      .setSize(w-30,20);
    
    gui.addSlider("size")
      .setSliderMode(Slider.FLEXIBLE)
      .setRange(0, 100)
      .setPosition(10,60)
      .setValue(30);    
    
    gui.addSlider("number")
      .setSliderMode(Slider.FLEXIBLE)
      .setDecimalPrecision(0)
      .setRange(0, 25)
      .setPosition(10,80)
      .setValue(2);    
     
    gui.addKnob("angle")
      .setViewStyle(Knob.ELLIPSE)
      .setRadius(22)
      .setStartAngle(PI/2)
      .setAngleRange(2*PI)
      .setRange(0, 360)
      .setPosition(10, 105)
      .setValue(0);
     
    gui.addKnob("alpha")
      .setViewStyle(Knob.ARC)
      .setRadius(22)
      .setStartAngle(PI/2)
      .setAngleRange(2*PI)
      .setRange(0, 1)
      .setPosition(62, 105)
      .setValue(0.8f);
     
    gui.addSlider("start color")
      .setRange(0, 100)
      .setPosition(10, 175);
     
    gui.addSlider("end color")
      .setRange(0, 100)
      .setPosition(10, 195)
      .setValue(90);    
  
    gui.addCheckBox("view")
      .setPosition(10, 225)
      .setSize(10, 10)
      .setItemsPerRow(1)
      .setSpacingColumn(75)
      .setSpacingRow(5)
      .addItem("debug", 0)
      .moveTo("global");
  
    //Export  
      
    gui.addButton("re-generate")
      .setPosition(10, 30)
      .setSize(w-30,20)
      .moveTo("export");      
    
    gui.addButton("export vector graphic")
      .setPosition(10, 60)
      .setSize(w-30,20)
      .moveTo("export");
      
    gui.addButton("export pixel graphic")
      .setPosition(10, 90)
      .setSize(w-30,20)
      .moveTo("export");

    //Autopilot

    gui.addButton("batch export")
      .setPosition(10, 30)
      .setSize(w-30,20)
      .moveTo("autopilot");
   
    gui.addSlider("iterations")
      .setSliderMode(Slider.FLEXIBLE)
      .setDecimalPrecision(0)
      .setRange(0, 100)
      .setPosition(10,65)
      .setValue(3)
      .moveTo("autopilot");
      
    gui.addCheckBox("randomize")
      .setPosition(10, 90)
      .setSize(10, 10)
      .setItemsPerRow(2)
      .setSpacingColumn(75)
      .setSpacingRow(5)
      .addItem("rnd size", 0)
      .addItem("rnd number", 0)
      .addItem("rnd angle", 0)
      .addItem("rnd alpha", 0)
      .addItem("rnd start col", 0)
      .addItem("rnd end col", 0)
      .moveTo("autopilot");    
  }

  public void draw() 
  {
    background(100);
  }
  

  
  public void controlEvent(ControlEvent theEvent) 
  {
    //Checkbox Events
    if(theEvent.isFrom("view")) 
    {
      if(PApplet.parseInt(theEvent.getGroup().getArrayValue()[0])==0)      
      {
        println("debug mode OFF");
        debug = false;
        origin.show();
      }
      else 
      {
        println("debug mode ON");
        debug = true;
        origin.debug();
      }    
    }  
    
    //Button and Slider Events
    if(theEvent.isController()) 
    {     
      if(theEvent.controller().name()=="generate") 
      {
        println("generating");
        origin.create();
        if(debug == false)
        {
          origin.show();
        }
        else
        {
          origin.debug();
        }
      }
      
      if(theEvent.controller().name()=="re-generate") 
      {
        println("generating... again");
        origin.create();
        if(debug == false)
        {
          origin.show();
        }
        else
        {
          origin.debug();
        }
      }


      if(theEvent.controller().name()=="export vector graphic") 
      {
        println("---");
        println("exporting pdf...");
        exPdf();
      }
      
      if(theEvent.controller().name()=="export pixel graphic") 
      {
        println("---");
        println("exporting jpg...");
        exPng();
      }
      
      if(theEvent.controller().name()=="batch export") 
      {
        println("---");
        println("starting batch export...");
        exBatch();
      }
      
    }
 
  }
  
  //Settings Window Setup
  
  private ControlFrame() {}

  public ControlFrame(Object theParent, int theWidth, int theHeight) 
  {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() 
  {
    return gui;
  }
  
  ControlP5 gui;
  Object parent;
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ometepe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
