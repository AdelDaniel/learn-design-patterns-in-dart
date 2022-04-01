# square pegs and round holes Example
    This example of the Adapter pattern is based on the classic conflict between square pegs and round holes.

- Structure of the Adapter pattern example
Adapting square pegs to round holes.
- The Adapter pretends to be a round peg, with a radius equal to a half of the square’s diameter (in other words, the radius of the smallest circle that can accommodate the square peg).

 - Example Source:  <a href="https://refactoring.guru/design-patterns/adapter" target="_blank">refactoring.guru/design-patterns/adapter</a> 
 <img src="../assets/square_pegs_and_round_holes._example.png" >

<img src="../assets/structure-object-adapter.png">

```dart

class RoundHole {
  int _radius;
  RoundHole({required int radius}) : _radius = radius;
  bool fits(RoundPeg roundPeg) => _radius >= roundPeg.radius;

}


class RoundPeg {
  int _radius;
  RoundPeg({required int radius}) : _radius = radius;
  int get radius => _radius;
}


class SquarePegAdapter implements RoundPeg {
  SquarePeg _squarePeg;
  SquarePegAdapter({required SquarePeg squarePeg}) : _squarePeg = squarePeg;
  SquarePeg get squarePeg => _squarePeg;

  @override
  int get radius => _squarePeg.width * sqrt(2) ~/ 2;
}


class SquarePeg {
  int _width;
  SquarePeg({required int width}) : _width = width;
  int get width => _width;
}



void main(List<String> args) {
  RoundHole hole = RoundHole(radius: 5);
  RoundPeg roundPeg = RoundPeg(radius: 5);
  print(hole.fits(roundPeg)); // true

  SquarePeg smallSquarePeg = SquarePeg(width: 5);
  SquarePeg largeSquarePeg = SquarePeg(width: 10);
  //! this won't compile (incompatible types);
  //! print(hole.fits(smallSquarePeg));

  SquarePegAdapter smallSquarePegAdapter =
      SquarePegAdapter(squarePeg: smallSquarePeg);
  SquarePegAdapter largeSquarePegAdapter =
      SquarePegAdapter(squarePeg: largeSquarePeg);
  print(hole.fits(smallSquarePegAdapter)); // true
  print(hole.fits(largeSquarePegAdapter)); // false
}

```