// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }
  /*
  @predateur
  faire passer la liste entiere des boids et le predateur a chaque boids 
  */
  void run(Predateur predateur) {
    for (Boid b : boids) {
      b.run(boids, predateur);
    }
  }
  void addBoid(Boid b) {
    boids.add(b);
  }
  void twick_separation(){
    
  }
  public ArrayList<Boid> getprays(){
    return boids;
  }
}
