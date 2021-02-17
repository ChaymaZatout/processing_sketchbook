// Chayma Zatout
// https://github.com/ChaymaZatout

//declare global variables:
int center_x, center_y;

void setup(){
  println("setup function ..");
  
  //set the frame size:
  size(600, 400);
  
  // set the background color:
  background(0);
  
  //initialize the variable center:
  center_x= width/2; // to a value equale to the window width /2 -> 600/2=300
  center_y= height/2;// to a value equale to the window height /2 -> 400/2=200
}

void draw(){
  // uncomment the next instruction and rerun again:
  //background(0);
  
  // draw a white ball at (center_x, center_y)
  fill(255);
  /*
    ps: center_x and center_y are updated with mouseX and mouseY respectively when the mouse is dragged.
    (see mouseDragged() function another built-in function)
  */
  circle(center_x, center_y, 20); // with radius = 20/2= 10
}

   
void mouseDragged(){
  center_x= mouseX;
  center_y= mouseY;
}
