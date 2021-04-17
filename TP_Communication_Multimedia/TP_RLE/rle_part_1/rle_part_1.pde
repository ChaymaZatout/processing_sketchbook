// Chayma Zatout
// https://github.com/ChaymaZatout

String in = new String("bbaaabaaa"); // la chaine de caractère à coder.
String decoder_str, encoder_str; // variables qui sert à afficher.
byte[] encoder_output= new byte[255];
int max_length= int(pow(2,15)); // La taille maximale d'une sous-chaine non continue.

void setup(){
  background(0);
  size(800, 300);
  
  // coder in:
  int out_cpt;
  out_cpt=RLE_encoder(in, encoder_output);
  
  // transformer le code generé en une chaine de caractères:
  char[] temp= new char[max_length];
  int temp_i= 0;
  for(int i=0; i<out_cpt; i++){
      String temp_str= hex(encoder_output[i]);
      for(int j=0; j<temp_str.length(); j++){
        temp[temp_i]= temp_str.charAt(j);
        temp_i+=1;
      }
      temp[temp_i]= ' ';
      temp_i+=1;
  }
  encoder_str = new String(temp, 0, temp_i);
  
  char[] docoded= new char[100];
  int nb_decoded= RLE_decoder(encoder_output, out_cpt, docoded);// decoder le code généré précédemment
  decoder_str = new String(docoded, 0, nb_decoded);
}

void draw(){
  background(0);
  fill(255);
  textSize(18);
  text("Encoding: "+ in, 10, 100);
  text("RLE Encoder: "+ encoder_str, 10, 150);
  text("RLE Decoder: "+ decoder_str, 10, 200);
  
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
int RLE_encoder(String input, byte[] output){
  int i_output=0;// la taille du tableau: output
  int nb_chars= input.length();
  int i=0;
  char[] temp = new char[nb_chars];
  int i_temp=0;
  
  while(i< nb_chars){
    char curr = input.charAt(i);
    
    // search for the continous sequence:
    int j = i+1;
    while(j< nb_chars && j-i< max_length && curr == input.charAt(j)){
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

int RLE_decoder(byte[] in, int nb_in, char[] out){
  int i=0;
  int out_i=0;
  char info;
  while(i<nb_in){
    info = byte2char(in, i);
    i+=2;
    if(info > pow(2,15)){
      for(int j=0; j<info-pow(2,15); j++){
        out[out_i]=char(in[i]);
        out_i+=1;
      }
      i+=1;
    }
    else{
      for(int j=0; j<info; j++){
        out[out_i]=char(in[i]);
        out_i+=1;
        i+=1;
      }
    }
  }
  
  return out_i;
}
