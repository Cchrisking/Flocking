// The Predateur class
class Predateur {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
    Predateur(float x, float y) {
    acceleration = new PVector(0, 0);
    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();
    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }
  void run(Flock flock) {
    //ArrayList<Boid> boids=flock.getprays();
    //hunt(boids);
    update();
    borders();
    render();
  }
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }
  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }
  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + radians(45);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    fill(255,204,0);
    stroke(150);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(14, 3.5); // first point
    vertex(21, 7); // second point
    vertex(21, 14); // third point
    vertex(14, 17.5); // fourth point
    vertex(7, 14); // fifth point
    vertex(7, 7); // sixth point
    endShape();
    popMatrix();
  }
  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}
