import 'dart:math';
import 'dart:ui';

class RandomColor {
  static Color random() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
