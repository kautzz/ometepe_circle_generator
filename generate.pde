public class Origin
{
    float originX, originY;
    float ax, ay, bx, by, cx, cy, dx, dy;
    float dist, angle;
    
    void create()
    {
      originX = random(width);
      originY = random(height);
     
      Controller s = guiWindow.gui.getController("size");      
      dist = s.getValue()*4;
      
      Controller a = guiWindow.gui.getController("angle");
      angle = radians(a.getValue())+PI/2;
      
      ax = originX + cos(angle)*dist;
      ay = originY + sin(angle)*dist;

      bx = originX + cos(angle+PI/2)*dist;
      by = originY + sin(angle+PI/2)*dist;

      cx = originX + cos(angle+PI)*dist;
      cy = originY + sin(angle+PI)*dist;
         
      dx = originX + cos(angle+PI+PI/2)*dist;
      dy = originY + sin(angle+PI+PI/2)*dist;
          
    }
    
    void getPos()
    {
      //spit out possible starting coordinates for satellites
      //probably not needed since we have ax - dy
      //depends on how class Satellites is implemented
    }
    
    void show()
    {
      //render the final image
      beginRecord(pdf);
      background(255);
      strokeWeight(0);

      beginShape(TRIANGLE_STRIP);
    
      for(float step=0; step<TWO_PI; step+=TWO_PI/720)
      { 
        stroke(lerpColor(0, 255, step/TWO_PI));
        fill(lerpColor(0, 255, step/TWO_PI));

        vertex(originX,originY);
        vertex(originX+cos(step+angle)*dist,originY+sin(step+angle)*dist);
      } 
      endShape();
      redraw();
      endRecord(); 

    }
    
    void debug()
    {
      //show how the image is constructed
      background(255);
      
      stroke(50, 50, 50);
      strokeWeight(0);
      fill(230,100); 

      ellipseMode(RADIUS);  
      ellipse(originX, originY, dist, dist);  

      stroke(150, 150, 150);
      strokeWeight(1);
      line(originX,originY,ax,ay);
      
      stroke(0, 0, 0);
      strokeWeight(4);
      point(originX,originY);

      stroke(204, 102, 0);
      point(ax,ay);
      stroke(0, 102, 204);
      point(bx,by);
      stroke(102, 204, 0);
      point(cx,cy);
      stroke(204, 0, 204);
      point(dx,dy);
      redraw();
     
    }
}
