// Chayma Zatout
// https://github.com/ChaymaZatout

char my_key=0;
byte[] my_byte= new byte[2];
char my_char;

void setup(){
  size(600, 250);
}

void draw(){
  background(0);
  fill(0, 128, 255);
  
  // Title:
  textAlign(CENTER);// center text:
  textSize(28);
  text("Byte <-> Char Converter:", width/2, 28);// center the title along x-axis
  
  // Converter text:
  textAlign(LEFT);
  textSize(22);
  fill(255);
  
  //1. display the pressed key:
  text("KEY: "+ my_key, 15, 100);
  //2. display the byte code:
  char2byte(my_key, my_byte, 0);
  text("BYTE: "+ hex(my_byte[0])+ " "+ hex(my_byte[1]), 15, 150);
  //3. display the char code:
  my_char = byte2char(my_byte, 0);
  text("CHAR: "+ my_char, 15, 200);
  
}

void keyPressed() {
  my_key=key;
}

void char2byte(char input_char, byte[] output_array, int index){
  output_array[index]= byte((input_char&0xFF00)>> 8);
  output_array[index+1]= byte(input_char&0x00FF);
} 

char byte2char(byte[] input_array, int index){
  return char(char(input_array[index]<<8)|char(input_array[index+1]));
}
