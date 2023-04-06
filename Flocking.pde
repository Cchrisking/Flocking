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
Settings setting;
AlignControl align;
CohisionControl coh;
SeparationControl sep;
void setup() {
  size(920, 620,P3D);
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
  /*separation*/
  // Draw the second scrollbar
  fill(200);
  rect(scrollBar2X, scrollBar2Y, scrollBarWidth, scrollBarHeight);
  float knobY2 = map(value2, maxValue, minValue, scrollBar2Y + scrollBarHeight, scrollBar2Y);
  fill(220,220,235);
  ellipse(scrollBar2X + scrollBarWidth/2, knobY2, 20, 20);

  // Draw the third scrollbar
  fill(200);
  rect(scrollBar3X, scrollBar3Y, scrollBarWidth, scrollBarHeight);
  float knobY3 = map(value3, maxValue, minValue, scrollBar3Y + scrollBarHeight, scrollBar3Y);
  fill(220,220,235);
  ellipse(scrollBar3X + scrollBarWidth/2, knobY3, 20, 20);
}
// Add a new boid into the System
void mousePressed(){
  if(mouseButton==LEFT){
    for(int i=0; i<10;i++){
  flock.addBoid(new Boid(mouseX,mouseY));
    }
  }
  else if(mouseButton==RIGHT){
    predateur=new Predateur(mouseX,mouseY);
  }
}
void addStorm(){
  for(int i=0; i<12; i++){
    flock.addWind(new Wind(width/4,height/4));
    }
}
void mouseDragged() {
  /*if (mouseX > scrollBarX && mouseX < scrollBarX + scrollBarWidth &&
      mouseY > scrollBarY && mouseY < scrollBarY + scrollBarHeight){
    value = map(mouseY, scrollBarY, scrollBarY + scrollBarHeight, maxValue, minValue);
    flock.setcohision(value);
  }*/
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
  
}
