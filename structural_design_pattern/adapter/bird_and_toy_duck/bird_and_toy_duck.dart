// Example:
// Suppose you have a Bird class with fly() ,
// and makeSound()methods.
// And also a ToyDuck class
// with squeak() method.
// Let’s assume that you are short on ToyDuck objects
// and you would like to use Bird objects in their place.
// Birds have some similar functionality but implement a different interface,
// so we can’t use them directly.
// So we will use adapter pattern.
// Here our client would be ToyDuck and adaptee would be Bird.

// Dart implementation of Adapter pattern
// source:: https://www.geeksforgeeks.org/adapter-pattern/

abstract class Bird {
  // birds implement Bird interface that allows
  // them to fly and make sounds adaptee interface
  void fly();
  void makeSound();
}

// a concrete implementation of bird
class Sparrow implements Bird {
  void fly() => print("Flying");
  void makeSound() => print("Chirp Chirp");
}

abstract class ToyDuck {
  // target interface
  // toyducks dont fly they just make
  // squeaking sound
  void squeak();
}

class PlasticToyDuck implements ToyDuck {
  void squeak() => print("Squeak");
}

class BirdAdapter implements ToyDuck {
  // You need to implement the interface your
  // client expects to use.
  Bird bird;

  // we need reference to the object we
  // are adapting
  BirdAdapter(Bird this.bird);

  // translate the methods appropriately
  @override
  void squeak() => bird.makeSound();
}

void main() {
  Bird sparrow = Sparrow();
  ToyDuck toyDuck = PlasticToyDuck();

  // Wrap a bird in a birdAdapter so that it
  // behaves like toy duck
  ToyDuck birdAdapter = BirdAdapter(sparrow);

  print("Sparrow...");
  sparrow.fly();
  sparrow.makeSound();

  print("ToyDuck...");
  toyDuck.squeak();

  // toy duck behaving like a bird
  print("BirdAdapter...");
  birdAdapter.squeak();
}

// Output:

// Sparrow...
// Flying
// Chirp Chirp
// ToyDuck...
// Squeak
// BirdAdapter...
// Chirp Chirp
