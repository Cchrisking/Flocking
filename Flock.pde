// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids
  ArrayList<Wind>windstorm;
  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
    windstorm=new ArrayList<Wind>();//Initialize the ArrayList for wind particles
  }
  void run(Predateur predateur) {
    for (Boid b : boids) {
      b.run(boids, predateur);
    }
  }
  void addBoid(Boid b) {
    boids.add(b);
  }
  void addWind(Wind w){
    windstorm.add(w);
  }
  void startStorm(){
    for(Wind particule:windstorm){
      particule.run(windstorm);
    }
  }
}
