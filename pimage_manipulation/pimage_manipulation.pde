// Chayma Zatout
// https://github.com/ChaymaZatout

PImage img;
int i;
void setup(){
  size(600, 400);
  
  img = loadImage("c_3.jpg");
  // display image height, width and size:
  println(img.height+" * "+ img.width+ " = "+ img.height*img.width);
  
  i=0;
}

void draw(){
  background(255);
  imageMode(CENTER);//center the image coordinates
  // display image:
  image(img, width/2, height/2);
  
  // update image pixels using the array 'pixels':
  img.loadPixels(); //Make sure the pixels are loaded
  img.pixels[i] = to_grayscale(img.pixels[i]);
  img.updatePixels();//Update the image with the data in its pixels[] array
  if(i< img.height* img.width) i+=1; // update to the next pixel index.
  
  // display text:
  fill(0, 128, 255);// text color
  textAlign(CENTER);// center the text coordinates
  textSize(20);
  // from i compute (row, column) the pixel coordinates:
  text("The "+i+" th pixel -> (row, column) = ("+ int(i/img.width)+", "+int(i%img.width)+")",
                                                          width/2, height/2+ img.height/2+ 20);
}

// convert the color c to grayscale value:
color to_grayscale(color c){
  // formula from: https://www.w3.org/TR/AERT/#color-contrast
  return color( 0.299 * red(c) + 0.587 * green(c) + 0.114 * blue(c));
}
