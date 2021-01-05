// Chayma Zatout
// https://github.com/ChaymaZatout

char[] text_char= new char[255];//char array to store the pressed keys
int text_len=0; // an index for text_char array

void setup(){
  size(600,200);
}

void draw(){
  background(0);// set the background to black.
  fill(255);// set the color for the next instructions to white
  text("Input text: "+new String(text_char), 10, 10);// display the string.
}

void keyPressed() {
  if (key != '\n') {
    text_char[text_len]=key;
    text_len+=1;
  }
  else{//if enter key is pressed then reinitialize the variables
    text_char= new char[255];
    text_len=0;
  }
}
