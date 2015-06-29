ControlFrame addControlFrame(String theName, int theWidth, int theHeight) 
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
      .setValue(5);    
    
    gui.addSlider("number")
      .setSliderMode(Slider.FLEXIBLE)
      .setDecimalPrecision(0)
      .setRange(0, 100)
      .setPosition(10,80)
      .setValue(10);    
     
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
      .setValue(1.0);
     
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
  

  
  void controlEvent(ControlEvent theEvent) 
  {
    //Checkbox Events
    if(theEvent.isFrom("view")) 
    {
      if(int(theEvent.getGroup().getArrayValue()[0])==0)      
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
        println("visualizing");
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
        println("visualizing... again");
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
        //exBatch();
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
