// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run(Predateur predateur) {
    for (Boid b : boids) {
      b.run(boids, predateur);  // Passing the entire list of boids to each boid individually
    }
  }
  void addBoid(Boid b) {
    boids.add(b);
  }
  public ArrayList<Boid> getprays(){
    return boids;
  }
}
