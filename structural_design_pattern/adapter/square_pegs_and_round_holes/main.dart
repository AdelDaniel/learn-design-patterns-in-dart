import 'round_hole.dart';
import 'round_peg.dart';
import 'square_peg.dart';
import 'square_peg_adapter.dart';

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
