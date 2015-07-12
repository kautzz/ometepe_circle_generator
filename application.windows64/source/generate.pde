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
    
    void create()
    {
      Controller sc = guiWindow.gui.getController("start color");
      sColor = int(map(sc.getValue(), 0, 100, 0, 255));
      
      Controller ec = guiWindow.gui.getController("end color");
      eColor = int(map(ec.getValue(), 0, 100, 0, 255));
      
      Controller al = guiWindow.gui.getController("alpha");
      alpha = int(map(al.getValue(), 0, 1, 0, 255));
       
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
    
    void generate()
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
        sColor = int(map(sc.getValue(), 0, 100, 0, 255));
      }
      
      if(autoSC.getArrayValue()[5] == 1)
      {
        eColor = (int)random(0,255);
        println("rnd end color "+eColor);
      }
      else
      {
        Controller ec = guiWindow.gui.getController("end color");
        eColor = int(map(ec.getValue(), 0, 100, 0, 255));
      }
      
      if(autoSC.getArrayValue()[3] == 1)
      {
        alpha = (int)random(0,255);
        println("rnd alpha "+alpha);
      }
      else
      {
        Controller al = guiWindow.gui.getController("alpha");
        alpha = int(map(al.getValue(), 0, 1, 0, 255));
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
    
    void populate()
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
    
    void show()
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
    
    void debug()
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