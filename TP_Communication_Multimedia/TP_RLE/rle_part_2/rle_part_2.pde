// Chayma Zatout

int max_length= int(pow(2,15));
PImage binary_image, decoded_image, original_image;
byte[] code;

void setup(){
  background(240);
  size(600, 600);
  binary_image = loadImage("c_1.jpg");
  original_image = loadImage("c_1.jpg");
  decoded_image = loadImage("c_1.jpg");
  
  binary_image.filter(THRESHOLD, 0.9);
  println(red((binary_image.get(0,0)))+" "+green(binary_image.get(0,0))+" "+ blue((binary_image.get(0,0))));
  
  code = new byte[binary_image.width* binary_image.height*2];
  int code_len= RLE_encoder(binary_image, code);
  decoded_image= RLE_decoder(code, code_len, decoded_image);
  
  binary_image.loadPixels();
  decoded_image.loadPixels();
  int i;
  for(i=0; i< decoded_image.width*decoded_image.height && decoded_image.pixels[i]==binary_image.pixels[i]; i++);
  println(decoded_image.width*decoded_image.height == i);
}

void draw(){
  background(240);
  
  imageMode(CENTER);//center the image coordinates
  // display image:
  image(original_image, width/2, height/4);
  image(binary_image, binary_image.width/2+50, 3*height/4);
  image(decoded_image, width - (decoded_image.width/2+50), 3*height/4);
  
  // draw title:
  fill(0, 128, 255);// text color
  textAlign(CENTER);// center the text coordinates
  textSize(30);
  text("RLE CODEC:", width/2, height/2+50);// center the title along x-axis
  
  // display caption:
  textAlign(CENTER);
  textSize(22);
  fill(0);
  text("Original image", width/2, height/4+binary_image.height/2+50);
  text("Coded image (thr= 0.9)", binary_image.width/2+50, 3*height/4+binary_image.height/2+50);
  text("Decoded image", width - (decoded_image.width/2+50), 3*height/4+binary_image.height/2+50);
  
}

// output_array[index] = byte(input_char)
void char2byte(char input_char, byte[] output_array, int index){
  output_array[index]= byte((input_char&0xFF00)>> 8);
  output_array[index+1]= byte(input_char&0x00FF);
} 

// char(input_array[index])
char byte2char(byte[] input_array, int index){
  return char(char(input_array[index]<<8)|char(input_array[index+1]));
}

// codeur RLE: code la chaine 'input' dans le tableau de byte 'output':
int RLE_encoder(PImage input, byte[] output){
  int i_output=0;// la taille du tableau: output
  int nb_chars= input.width* input.height;
  int i=0;
  byte[] temp = new byte[nb_chars];
  int i_temp=0;
  loadPixels();
  while(i< nb_chars){
    byte curr = (brightness(input.pixels[i]))>= 0.5? byte(255): byte(0);
    
    // search for the continous sequence:
    int j = i+1;
    
    while(j< nb_chars && j-i< max_length && curr == ((brightness(input.pixels[j]))>= 0.5? byte(255): byte(0))){
      j++;
    }
  
    // verify if it's a continous sequence to encode:
    if(j-i>= 3){
      //A: encode the sequence that is not continous:
      if(i_temp>0){
        //A.1: encode the lenghth:
        char2byte(char(i_temp), output, i_output);
        i_output += 2;
        //A.2: encode the sequence:
        for(int k=0; k< i_temp; k++){
          output[i_output+k]=byte(temp[k]);
      }
      //A.3: update i:
      i_output += i_temp;
      i_temp=0;
    }
      
      //B: Encode the continous sequence:
      //B.1: encode the lenghth:
      char2byte(char(j-i+int(pow(2,15))),output, i_output);
      //B.2: encode the sequence:
      output[i_output+2]= byte(curr);
      //B.3: update i:
      i_output+=3;
      i=j;
    }
    else{
      // if it's not continous, update temp:
      temp[i_temp]=curr;
      i_temp+=1;
      i+=1;
    }
  }
  
  if(i_temp>0){
    //A: encode the sequence that is not continous:
      //A.1: encode the lenghth:
      char2byte(char(i_temp), output, i_output);
      i_output += 2;
      //A.2: encode the sequence:
      for(int k=0; k< i_temp; k++){
        output[i_output+k]=byte(temp[k]);
      }
      //A.3: update i:
      i_output += i_temp;
      i_temp=0;
  }
  return i_output;
}

PImage RLE_decoder(byte[] in, int nb_in, PImage out){
  int i=0;
  int out_i=0;
  char info;
  loadPixels();
  while(i<nb_in){
    info = byte2char(in, i);
    i+=2;
    if(info > pow(2,15)){
      for(int j=0; j<info-pow(2,15); j++){
        out.pixels[out_i]=color(int(in[i]));
        out_i+=1;
      }
      i+=1;
    }
    else{
      for(int j=0; j<info; j++){
        out.pixels[out_i]=color(int(in[i]));
        out_i+=1;
        i+=1;
      }
    }
  }
  updatePixels();
  return out;
}
