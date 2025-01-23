class Vector2d {
  final int x;
  final int y;

  const Vector2d(this.x, this.y);

  const Vector2d.left()
      : x = -1,
        y = 0;
  const Vector2d.right()
      : x = 1,
        y = 0;
  const Vector2d.up()
      : x = 0,
        y = -1;
  const Vector2d.down()
      : x = 0,
        y = 1;

  Vector2d operator +(Vector2d other) {
    return Vector2d(x + other.x, y + other.y);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Vector2d) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return '$x,$y';
  }
}
