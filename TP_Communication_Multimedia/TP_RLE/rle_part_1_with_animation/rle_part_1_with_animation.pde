// Chayma Zatout
// https://github.com/ChaymaZatout

int max_size=255;
int max_len= int(pow(2,15));

char[] to_encode= new char[max_size];
byte[] encoder= new byte[max_size];
int to_encode_len=0;
String text_str;
String decoder_str= new String();
String encoder_str= new String();

void setup(){
  size(1000,200);
}

void draw(){
  background(0);
  fill(255);
  textSize(18);
  text_str= new String(to_encode, 0, to_encode_len);
  text("Input text: "+text_str, 10, 50);
  text("RLE encoder: "+encoder_str, 10, 100);
  text("RLE decoder: "+decoder_str, 10, 150);

}

void keyPressed() {
  if(key=='\n'){
    to_encode= new char[max_size];
    to_encode_len=0;
    decoder_str = new String();
    encoder_str = new String();
  }
  else if(key==''){//DELETE CHAR
    if(to_encode_len > 0){
      //to_encode[to_encode_len]='\0';
      to_encode_len-=1;
      
      //encode:
      encoder= new byte[max_size];
      int enc_len= RLE_encoder(new String(to_encode, 0, to_encode_len), encoder);
      encoder_str= new String();
      for(int i=0; i<enc_len; i++) encoder_str += hex(encoder[i]);
      
      //decode:
      char[] docoded= new char[max_size];
      int dec_len= RLE_decoder(encoder, enc_len, docoded);
      decoder_str = new String(docoded, 0, dec_len);
    }
  }
  else {
    to_encode[to_encode_len]=key;
    to_encode_len+=1;
    print(key);
    //encode:
    encoder= new byte[max_size];
    int enc_len= RLE_encoder(new String(to_encode, 0, to_encode_len), encoder);
    encoder_str= new String();
    for(int i=0; i<enc_len; i++) encoder_str += hex(encoder[i]);
    
    //decode:
    char[] docoded= new char[max_size];
    int dec_len= RLE_decoder(encoder, enc_len, docoded);
    decoder_str = new String(docoded, 0, dec_len);
    
  }
}


void char2byte(char input_char, byte[] output_array, int index){
  output_array[index]= byte((input_char&0xFF00)>> 8);
  output_array[index+1]= byte(input_char&0x00FF);
} 

char byte2char(byte[] input_array, int index){
  return char(char(input_array[index]<<8)|char(input_array[index+1]));
}

int RLE_encoder(String input, byte[] output){
  int i_output=0;
  int nb_chars= input.length();
  int i=0;
  char[] temp = new char[nb_chars];
  int i_temp=0;
  
  while(i< nb_chars){
    char curr = input.charAt(i);
    
    // search for the continous sequence:
    int j = i+1;
    while(j< nb_chars && j-i< max_len && curr == input.charAt(j)){
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
