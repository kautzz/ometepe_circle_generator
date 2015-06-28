public void exPdf()
{
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF, "images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".pdf");
  
  //record pdf and redraw geometry
  beginRecord(pdf);
  origin.show();
  endRecord(); 
  
  println("success saving: "+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".pdf");
  println("---");
}

public void exPng()
{
  // Generate timestring, use vars!
  save("images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png");
  println("success saving: "+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png");
  println("---");
}

public void exBatch()
{

}
