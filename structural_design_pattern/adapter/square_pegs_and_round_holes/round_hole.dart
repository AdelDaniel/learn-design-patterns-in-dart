import 'round_peg.dart';

class RoundHole {
  int _radius;
  RoundHole({required int radius}) : _radius = radius;

  bool fits(RoundPeg roundPeg) => _radius >= roundPeg.radius;

  @override
  String toString() => 'RoundHole(radius: $_radius)';
}
