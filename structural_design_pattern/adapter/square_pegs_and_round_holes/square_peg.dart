class SquarePeg {
  int _width;
  SquarePeg({required int width}) : _width = width;
  int get width => _width;
  @override
  String toString() => 'SquarePeg(_width: $_width)';
}
