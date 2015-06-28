public void exPdf()
{
  //copy temp.pdf to timestamp.pdf
  //pdf.renameTo(savePath("foooo"), "temp.pdf");
  //myFile.renameTo ("foo.pdf");
}

public void exPng()
{
  save("images/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png");
  println("success saving: "+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png");
  println("---");
}

public void exBatch()
{

}
