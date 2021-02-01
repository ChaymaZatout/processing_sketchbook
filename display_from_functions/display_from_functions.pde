// Chayma Zatout
// https://github.com/ChaymaZatout
/*
  This sketch investigates the possiblity of updating the display from functions.
  It also shows where to use the functions: loadPixels() and updatePixels();
  
  Conclusion: the display window can be changed from functions but,
  you have to consider where to place loadPixels() and updatePixels().
*/
int d=0;
int i=0,j=0;
void setup(){
  size(600,400);
  background(0);
}
void draw(){
  // FIRST EXAMPLE:
  /*
    We update for each pixel from the frequent_update() function: blocking.
  */
  //if(d==0) {
  //  println("start");
  //  frequent_update();
  //  d++;
  //  println("end");
  //}
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  // SECOND EXAMPLE:
  /*
    This example is similar for the first one, but it runs directly from the draw function: blocking
  */
  //println("start");
  //for(int i=0; i<height; i++){
  //  for(int j=0; j<width; j++){
  //    loadPixels();
  //    pixels[width*i+j]= color(random(255), random(255), random(255));
  //    updatePixels();
  //  }
  //}
  //println("end");
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  // THIRD EXAMPLE:
  /*
    In this example, we placed loadPixels() and updatePixels() outside the loop: 
    it runs smoothly but it updates all pixels at once.
  */
  //loadPixels();
  //for(int i=0; i<height; i++){
  //  for(int j=0; j<width; j++){
  //    pixels[width*i+j]= color(random(255), random(255), random(255));
  //  }
  //}
  //updatePixels();
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  // FORTH EXAMPLE:
  /*
    This example is similar for the third one, but it but it uses a function: 
    it runs smoothly but it updates all pixels at once.
  */
  //if(d==0) {
  //  println("start");
  //  frequent_update_v2();
  //  d++;
  //  println("end");
  //}
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  //FIFTH EXAMEPLE:
  /*
    We update smoothly each pixel and from a function!
  */
  if(j==width){ 
    j=0;
    i++; 
  }
  if(i==height) i=0;
  frequent_update_v3(i, j);
  j++;
  
  
}

void frequent_update(){
  for(int i=0; i<height; i++){
    for(int j=0; j<width; j++){
      loadPixels();
      pixels[width*i+j]= color(random(255), random(255), random(255));
      updatePixels();
    }
  }
}

void frequent_update_v2(){
  loadPixels();
  for(int i=0; i<height; i++){
    for(int j=0; j<width; j++){
      pixels[width*i+j]= color(random(255), random(255), random(255));
    }
  }
  updatePixels();
}

void frequent_update_v3(int i, int j){
  loadPixels();
  pixels[width*i+j]= color(random(255), random(255), random(255));
  updatePixels();
}
