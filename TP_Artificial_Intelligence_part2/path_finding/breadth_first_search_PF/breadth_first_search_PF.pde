PathFinding pf;
BFS bfs;
boolean speed;

void setup(){
  size(512, 512);
  pf= new PathFinding("env.txt", ",", 2, 3, 0, 1);
  bfs= new BFS(pf);
  
  speed= false;
}

void draw(){
  background(0);
  pf.draw_environement(width, height);
  
  if(speed){
    bfs.process();
  }
  
  if(bfs.achieved){
    pf.make_step(bfs.path);
    delay(1000);
  }
  
  fill(255);
  textSize(18);
  text("* Press 's' to speed-up/slow-down",10, 15);
  
}

void keyPressed(){
  if(key=='s'){
    speed= !speed;
  }
  else if(key==' ' && !speed){
    bfs.process();
  }
}
