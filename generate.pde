public void visualize()
{
  // might be redundant call draw and create from button trigger
  
  //draw origin
  Origin origin = new Origin();
  origin.create();
  origin.debug();
  
  //draw childs    
  
}  


public class Origin
{

    float originX, originY;
    float ax, ay, bx, by, cx, cy, dx, dy;
    float py;
    float dist;
    
    void create()
    {
      originX = random(width);
      originY = random(height);
     
      Controller s = guiWindow.gui.getController("size");
      println(s.getValue());    
      
      dist = s.getValue()*0.01*height/2;

      py = originY + dist;
      
      ax = originX;
      ay = originY + dist;

          
    }
    
    void getPos()
    {
      //spit out possible starting coordinates for satellites
    }
    
    void show()
    {
      //render the final image
    }
    
    void debug()
    {
      //show how the image is constructed
      
      background(255);
      stroke(204, 102, 0);
      strokeWeight(5);
      point(originX,originY);
      
      ellipseMode(CENTER);  
      fill(100); 
      ellipse(originX, originY, originX + dist, py);  
    
      stroke(0, 0, 0);
      strokeWeight(1);
      
      line(originX,originY,ax,ay);
    }
}
