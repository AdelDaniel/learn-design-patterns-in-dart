import 'dart:math';

import 'round_peg.dart';
import 'square_peg.dart';

class SquarePegAdapter implements RoundPeg {
  SquarePeg _squarePeg;
  SquarePegAdapter({required SquarePeg squarePeg}) : _squarePeg = squarePeg;
  SquarePeg get squarePeg => _squarePeg;

  @override
  int get radius => _squarePeg.width * sqrt(2) ~/ 2;
}
