class Point {
  final int x;
  final int y;

  Point(int x, int y)
      : x = x,
        y = y {}
}

class ImmutablePoint {
  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y);
}

void main() {
  const point = ImmutablePoint(2, 3);
  print(point.x);
}
