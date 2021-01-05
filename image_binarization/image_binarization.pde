// Chayma Zatout
// https://github.com/ChaymaZatout

// declare an image:
PImage img, img_bin;
int i, threshold;

void setup(){
  size(600, 300);
  //load image:
  img = loadImage("c_1.jpg");
  img_bin = loadImage("c_1.jpg");
  // convert to grayscale:
  img.filter(GRAY);
  img_bin.filter(GRAY);
  
  // display image height, width and size:
  println(img.height+" * "+ img.width+ " = "+ img.height*img.width);
  
  // initialize variables:
  i=0;
  threshold = 150;
}

void draw(){
  //initialize background with white:
  background(255);
  
  // draw title:
  fill(0, 128, 255);// text color
  textAlign(CENTER);// center the text coordinates
  textSize(28);
  text("Image Binarization:", width/2, 28);// center the title along x-axis
  
  imageMode(CENTER);//center the image coordinates
  // display image:
  image(img, img.width/2+50, height/2);
  
  
  // binarize img_bin:
  if(i< img_bin.height*img_bin.width){
    if(brightness(img_bin.pixels[i]) > threshold)
      img_bin.pixels[i]  = color(255);
    else
      img_bin.pixels[i]  = color(0);
    img_bin.updatePixels();
  }
  else{
    // here i == image size; reinitialize i and the image to binarize again:
    i=-1;
    img_bin = loadImage("c_1.jpg");
    img_bin.filter(GRAY);
  }
  //show image after binarizing a single pixel i:
  image(img_bin, width- (img_bin.width/2+50), height/2);
  i+=1; // update i to binarize the next pixel.
  
  // display images titles:
  textAlign(CENTER);
  textSize(22);
  fill(0);
  text("Original Image", img.width/2+50, height/2+img.width/2+5);
  text("Binary Image", width- (img_bin.width/2+50), height/2+img_bin.width/2+5);
  
}
