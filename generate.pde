public class Origin
{
    float originX, originY;
    float ax, ay, bx, by, cx, cy, dx, dy;
    float dist, angle, alpha;
    int sColor, eColor;
    
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
      
      Controller sc = guiWindow.gui.getController("start color");
      sColor = int(map(sc.getValue(), 0, 100, 0, 255));
      
      Controller ec = guiWindow.gui.getController("end color");
      eColor = int(map(ec.getValue(), 0, 100, 0, 255));
      
      Controller al = guiWindow.gui.getController("alpha");
      alpha = int(map(al.getValue(), 0, 1, 0, 255));

      
      
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
      background(255);
      strokeWeight(0);
      strokeCap(SQUARE);
      //noStroke();
      beginShape(TRIANGLE_STRIP);
    
      for(float step=0; step<=TWO_PI; step+=TWO_PI/7)
      { 
        stroke(lerpColor(sColor, eColor, step/TWO_PI),alpha);
        fill(lerpColor(sColor, eColor, step/TWO_PI),alpha);

        vertex(originX,originY);
        vertex(originX+cos(step+angle)*dist,originY+sin(step+angle)*dist);
      } 
      endShape();
      redraw();

    }
    
    void debug()
    {
      //show how the image is constructed
      strokeCap(ROUND);
      background(255);
      
      stroke(190, 190, 190, alpha);
      strokeWeight(1);
      fill(230, alpha); 

      ellipseMode(RADIUS);  
      ellipse(originX, originY, dist, dist);  

      stroke(150, 150, 150, alpha);
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
