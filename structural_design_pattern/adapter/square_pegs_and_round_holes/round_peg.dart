class RoundPeg {
  int _radius;
  RoundPeg({required int radius}) : _radius = radius;
  int get radius => _radius;
  @override
  String toString() => 'RoundPeg(_radius: $_radius)';
}
