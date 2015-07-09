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

}
