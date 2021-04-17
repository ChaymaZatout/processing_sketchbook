// Zatout Chayma
// https://github.com/ChaymaZatout
// generate a configuration for path finding. You can improve this sketch by creating env with a given size.
// You can change the robot initial position and the objective position by dragging them.

int [][]env= {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,2,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,3,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};         
int stepx,stepy, x_dragged, y_dragged;

void setup() {
  size(512, 512);
  stepx=width/16;
  stepy=height/16;
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {
      color c=color(0, 0, 0);
      int i= y/stepy, j=x/stepx;
      switch (env[i][j]){
        case 1: c= color(0, 0, 255); break;
        case 2: c= color(255, 0, 0); break;
        case 3: c= color(0, 255, 0); break;
      }      
      pixels[x+ y* width]= c;
    }
  }
  updatePixels();
  
  fill(255);
  text("* Click to create/remove obstacles\n* Drag to exchange positions\n* Press 'S' to save the current ENV",10, 15);
}

void mouseClicked(){
  int i= mouseY/stepy, j=mouseX/stepx;
  int val=env[i][j];
  if(val == 0) env[i][j]=1;
  else if(val == 1) env[i][j]=0;
}

void mousePressed(){
  x_dragged=mouseX/stepx;
  y_dragged=mouseY/stepy;
}

void mouseReleased(){
  int val = env[y_dragged][x_dragged];
  env[y_dragged][x_dragged] = env[mouseY/stepy][mouseX/stepx];
  env[mouseY/stepy][mouseX/stepx] = val;
}

void keyPressed(){
  if(key == 's'){
    // save as image:
    saveFrame("env.bmp");
    //save matrix:
    String[] lines = new String[env.length]; 
    for (int i = 0; i < env.length; i++) {
      lines[i]="";
      for (int j = 0; j < env[i].length; j++) {
       lines[i] += env[i][j] +(j==env[i].length-1? "":",");
      }
    }
    saveStrings("env.txt", lines);
  }
}
