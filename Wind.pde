// The Wind class
class Wind {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  float intermolecular_space = 50.0f;
  Wind(float x, float y) {
    float angle = random(TWO_PI);
    acceleration = new PVector(0, 0);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 1;
    maxforce = 0.01;
  }
  void run(ArrayList<Wind> winds) {
    storm(winds);
    update();
    borders();
    render();
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  void render() {
    float theta = velocity.heading() + radians(45);
    fill(255,0,0);
    stroke(10);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(7, 1.75); // first point
    vertex(10.1, 3.5); // second point
    vertex(10.5, 7); // third point
    vertex(7, 8.75); // fourth point
    vertex(3.75, 7); // fifth point
    vertex(3.5, 3.5); // sixth point
    endShape();
    popMatrix();
  }
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
    void storm(ArrayList<Wind> winds) {
    PVector sep = separate(winds);   // Separation
    // Arbitrarily weight these forces
    sep.mult(1.5);
    //Add the force vectors to acceleration
    applyForce(sep);
  }
    PVector separate (ArrayList<Wind> winds) {
    //float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Wind particule : winds) {
      float d = PVector.dist(position, particule.position);
      if ((d > 0) && (d < intermolecular_space)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, particule.position);
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
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
   PVector align (ArrayList<Wind> winds) {
    float neighbordist = 25;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Wind particule : winds) {
      float d = PVector.dist(position, particule.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(particule.velocity);
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
}
