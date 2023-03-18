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

void setup() {
  size(640, 360,P3D);
  flock = new Flock();
  predateur=new Predateur(width/2, height/2);
  // Add an initial set of boids into the system
  for (int i = 0; i < 5; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  background(50,75,25);
  flock.run(predateur);
  predateur.run(flock);
}

// Add a new boid into the System
void mousePressed() {
  if(mouseButton==LEFT){
  flock.addBoid(new Boid(mouseX,mouseY));
  System.out.println("Hello left world "+mouseX+";"+mouseY);
  }
  else if(mouseButton==RIGHT){
    System.out.println("Hello right world "+mouseX+";"+mouseY);
    predateur=new Predateur(mouseX,mouseY);
  }
}
