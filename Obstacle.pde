class Obstacle
{
  int xpos;
  int ypos;
  int w;
  int h;
  
  Obstacle(int a,int b,int c,int d)
  {
    xpos = a;
    ypos = b;
    w = c;
    h = d;
    
    show();
  }
  
  void show()
  {
    fill(153,0,153);
    rect(xpos,ypos,w,h);
  }
}
