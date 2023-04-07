// The Boid class
class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float desiredseparation = 25.0f;
  float sepValue;
  float coValue;
  float alignValue;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  Boid(float x, float y) {
    sepValue=25.0;
    coValue=25.0;
    alignValue=25.0;
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }
  void deltasep(float value){
    desiredseparation=value;
  }
  void run(ArrayList<Boid> boids, Predateur predateur,ArrayList<Wind>winds) {
    flock(boids, predateur,winds);
    update();
    borders();
    render();
  }
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids, Predateur predateur,ArrayList<Wind>winds) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    PVector sur=avoid_predator(predateur);
    PVector storm=storm(winds);
    // Arbitrarily weight these forces
    //if(sur.x > 0 && sur.y > 0) System.out.println(sur);
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    sur.mult(1.5);
    storm.mult(1.5);
    //Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(sur);
    applyForce(storm);
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
  void render(){
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    fill(0,0,252);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
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
  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = sepValue;
    System.out.println("Chision: "+desiredseparation);
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }
    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
   PVector avoid_predator (Predateur predator) {
   float safezone = 50.0f;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
      float d = PVector.dist(position, predator.position);
      if ((d > 0) && (d < safezone)) {
        PVector diff = PVector.sub(position, predator.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
     if (count > 0) {
      sum.div((float)count);
     }
    // As long as the vector is greater than 0
     if (sum.mag() > 0) {
      sum.normalize();
      sum.mult(maxspeed);
      sum.sub(velocity);
      sum.limit(0.75);
     }
    return sum;
  }
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = alignValue;
    System.out.println("align: "+neighbordist);
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = coValue;
    System.out.println("Chision: "+neighbordist);
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0,0);
    }
  }
  PVector storm(ArrayList<Wind>winds){
    float intermolecular_dist=20.0;
    float d= 0;
    PVector vect_pos=new PVector(0,0);
    int count=0;
    for(Wind particule:winds){
      d=PVector.dist(position,particule.position);
      if(d<intermolecular_dist){
        vect_pos.add(particule.position);
        count++;
      }
    }
    if(count>0){
      vect_pos.div((float)count);
      vect_pos.normalize();
      PVector steer=PVector.sub(vect_pos,velocity);
      steer.limit(maxforce);
      return steer;
    }else{
      return new PVector(0,0,0);
    }
  }
  void set_cohesion(float potential){
    coValue=potential;
  }
  void set_separation(float potential){
    sepValue=potential;
  }
  void set_align(float potential){
    alignValue=potential;
  }
}
