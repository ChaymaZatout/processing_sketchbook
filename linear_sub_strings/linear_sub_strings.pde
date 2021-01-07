// Chayma Zatout
// https://github.com/ChaymaZatout
/*
  display all the continous substrings from the string given by the user
*/

String s="", // string to process
       s_temp=""; // temporare string used to display what the user is tapping
int min_length = 3; // from what we start concidering a linear sub-string
char[] text_char= new char[255];//char array to store the pressed keys
int text_len=0; // an index for text_char array

void setup(){
  size(600, 400);
  background(0);
}

void draw(){
  background(0); //<>//
  textSize(18);
  fill(255);
  
  // display what the user is tapping:
  text("Input String: "+ s_temp, 20, 50);
  
  //start searching all the substrings:
  int i=0, y=100;
  while(i< s.length()){
    char current = s.charAt(i);
    int j;
    // start searching if it's an continious sub string:
    for(j=i+1; j<s.length() && s.charAt(j)==current; j++);
    
    // if the current sub string is considered?
    if(j-i >= min_length){
      text(current+": from "+ str(i)+" to "+ str(j)+", (len="+ str(j-i)+")", 50, y);
      y+=30;// print the next substring to the next line
    }
    
    i=j;
  }

}

void keyPressed() {
  s = new String();
  
  if (key != '\n') {
    text_char[text_len]=key;
    text_len+=1;
    s_temp= new String(text_char, 0, text_len);
  }
  else{//if enter key is pressed then reinitialize the variables
    // to process the entire string only:
    s= new String(text_char, 0, text_len);
    text_char= new char[255];
    text_len=0;
  }
}
