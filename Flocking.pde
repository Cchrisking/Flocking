/**
 * Flocking 
 * by Daniel Shiffman.  
 * 
 * An implementation of Craig Reynold's Boids program to simulate
 * the flocking behavior of birds. Each boid steers itself based on 
 * rules of avoidance, alignment, and coherence.
 * 
 * Click the mouse to add a new boid.
 */
Flock flock;
Predateur predateur;
Boid boid;
Wind wind;
float value = 25.0;
float value2 = 0.0;
float value3 = 0.0;
float valuesep=25.0;
float minValue = 0.0;
float maxValue = 100.0;
float scrollBarWidth = 20;
float scrollBarHeight = 200;
float scrollBarX = 50;
float scrollBarY = 50;
// Define dimensions for the second scrollbar
float scrollBar2X = 80;
float scrollBar2Y = 50;
// Define dimensions for the third scrollbar
float scrollBar3X = 110;
float scrollBar3Y = 50;
/*Togle button for predator*/
boolean predatorstate = false;
boolean windstate = false;
Settings setting;
AlignControl align;
CohisionControl coh;
SeparationControl sep;
void setup() {
  size(1100, 820,P3D);
  flock = new Flock();
  predateur=new Predateur(width/2, height/2);
  wind=new Wind(width/2, height/2);
  setting = new Settings();
  align= new AlignControl();
  coh=new CohisionControl();
  sep=new SeparationControl();
  // Add an initial set of boids into the system
  for (int i = 0; i < 25; i++){
    flock.addBoid(new Boid(width/2,height/2));
  }
  for(int i=0; i<15;i++){ 
  flock.addWind(wind);
  }
}
void draw() {
  background(173,216,230);
  flock.run(predateur);
  predateur.run();
  flock.startStorm();
  fill(200);
  rect(coh.getX(), coh.getY(), scrollBarWidth, scrollBarHeight);
  float knobY = map(value, coh.getMaxValue(), coh.getMinValue(), coh.getX(), coh.getY() + scrollBarHeight);
  fill(220,220,235);
  ellipse(coh.getY() + scrollBarWidth/2, knobY, 20, 20);
  // Add text label to scrollBar
  String label = "CO: " + value; // Replace with your desired label text
  textSize(12); // Set the font size
  textAlign(CENTER, CENTER); // Center the text horizontally and vertically
  fill(0); // Set the text color to black
  text(label, coh.getX() + scrollBarWidth/2, coh.getY() + coh.getY()-(50+coh.getY()/2));
  /*separation*/
  // Draw the second scrollbar
  fill(200);
  rect(scrollBar2X, scrollBar2Y, scrollBarWidth, scrollBarHeight);
  float knobY2 = map(value2, sep.getMaxValue(), sep.getMinValue(), sep.getX(), sep.getY() + scrollBarHeight);
  fill(220,220,235);
  ellipse(scrollBar2X + scrollBarWidth/2, knobY2, 20, 20);
  // Add text label to scrollBar
  String labelsep = "SE: " + value2; // Replace with your desired label text
  textSize(12); // Set the font size
  textAlign(CENTER, CENTER); // Center the text horizontally and vertically
  fill(0); // Set the text color to black
  text(labelsep, sep.getX() + scrollBarWidth/2, sep.getY() + sep.getY()-(50+sep.getY()/2));
  // Draw the third scrollbar
  fill(200);
  rect(align.getX(), align.getY(), scrollBarWidth, scrollBarHeight);
  float knobY3 = map(value3, align.getMaxValue(), align.getMinValue(), align.getX(), align.getY() + scrollBarHeight);
  fill(220,220,235);
  ellipse(scrollBar3X + scrollBarWidth/2, knobY3, 20, 20);
  // Add text label to scrollBar
  String labelalign = "Align: " + value3; // Replace with your desired label text
  textSize(12); // Set the font size
  textAlign(CENTER, CENTER); // Center the text horizontally and vertically
  fill(0); // Set the text color to black
  text(labelalign, align.getX() + scrollBarWidth/2, align.getY() + align.getY()-(50+align.getY()/2));
  /*Draw toggle button for predator*/
  if (predatorstate) {
    fill(70, 220, 0);
  } else {
    fill(220, 70, 0);
  }
  rect(50, 265, 75, 25,16);
  /*round bouton*/
  fill(220, 220, 220);
  int xm=25;
  if (predatorstate) {
    xm=113;
  } else {
    xm=62;
  }
  ellipse(xm, 277.5, 23, 23);
  /*End drawing toggle button for wind*/
  if (windstate) {
    fill(70, 220, 0);
    
  } else {
    fill(220, 70, 0);
  }
  rect(50, 300, 75, 25,16);
  /*round bouton*/
  fill(220, 220, 220);
  int x=25;
  if (windstate) {
    x=113;
  } else {
    x=62;
  }
  ellipse(x, 312.5, 23, 23);
  /*End drawing toggle button for wind*/
}
// Add a new boid into the System
void mousePressed(){
  if(mouseButton==LEFT){
    if (mouseX > 120 && mouseX < 820 && mouseY > 0 && mouseY < width) {
    
    for(int i=0; i<10;i++){
  flock.addBoid(new Boid(mouseX,mouseY));
    }
    }
  }
  else if(mouseButton==RIGHT){
    predateur=new Predateur(mouseX,mouseY);
  }
  /*if predator toggle pressed*/
   if (mouseX > 50 && mouseX < 150 && mouseY > 300 && mouseY < 325) {
    windstate = !windstate;
  }
  /*if predator toggle pressed*/
   if (mouseX > 50 && mouseX < 150 && mouseY > 265 && mouseY < 290) {
    predatorstate = !predatorstate;
  }
}
void addStorm(){
  for(int i=0; i<12; i++){
    flock.addWind(new Wind(width/2,height/2));
    }
}
void mouseDragged() {
  if (mouseX > coh.getX() && mouseX < coh.getX() + scrollBarWidth &&
      mouseY > coh.getY() && mouseY < coh.getY() + scrollBarHeight){
        value = map(mouseY, coh.getY(), coh.getY() + scrollBarHeight, coh.getMaxValue(), coh.getMinValue());
        flock.setcohision(value);
  }
  if (mouseX > sep.getX() && mouseX < sep.getX() + scrollBarWidth &&
      mouseY > sep.getY() && mouseY < sep.getY() + scrollBarHeight){
        value2 = map(mouseY, sep.getY(), sep.getY() + scrollBarHeight, sep.getMaxValue(), sep.getMinValue());
        flock.setseparation(value2);
  }
   if (mouseX > align.getX() && mouseX < align.getX() + scrollBarWidth &&
      mouseY > align.getY() && mouseY < align.getY() + scrollBarHeight){
        value3 = map(mouseY, align.getY(), align.getY() + scrollBarHeight, align.getMaxValue(), align.getMinValue());
        flock.setalign(value3);
  }
  
}
