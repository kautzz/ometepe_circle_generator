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
