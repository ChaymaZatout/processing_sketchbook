// Chayma Zatout
// https://github.com/ChaymaZatout

color c;

void setup(){
  size(750, 400);
  c = color(random(255), random(255), random(255));
}

void draw(){
  background(255);
  // display the color:
  fill(c);
  circle(150, height/4, 50);
  
  //display color components:
  fill(red(c), 0, 0);
  circle(300, height/4, 50);
  fill(0, green(c),0);
  circle(450, height/4, 50);
  fill(0, 0, blue(c));
  circle(600, height/4, 50);
  
  // display color hue, brightness, saturation:
  fill(hue(c));
  circle(150, 3*height/4 - 25, 150);
  fill(brightness(c));
  circle((150+600)/2, 3*height/4 - 25, 150);
  fill(saturation(c));
  circle(600, 3*height/4 - 25, 150);
  
  // set title:
  fill(0, 128, 255);
  textAlign(CENTER);// center text:
  textSize(28);
  text("Color components: ", width/2, 28);
  fill(0);
  textSize(16);
  text("<Click to change the color>", width/2, 50);
  
  //text for components:
  textSize(50);
  text("=", (150+300)/2, height/4+25);
  text("+", (300+450)/2, height/4+25);
  text("+", (450+600)/2, height/4+25);
  
  textSize(28);
  text("Hue", 150, 3*height/4+75);
  text("Brightness", (150+600)/2, 3*height/4+75);
  text("Saturation", 600, 3*height/4+75);
}

void mouseClicked(){
  c = color(random(255), random(255), random(255));
}
