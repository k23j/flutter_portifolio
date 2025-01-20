import 'package:flutter/material.dart';

final ColorScheme defaultColorScheme =
    ColorScheme.fromSeed(seedColor: Color(0xFF495F73)).copyWith(
  primaryContainer: const Color(0xFF495F73),
  secondaryContainer: const Color(0xFFBACBD9),
);

final TextTheme defaultTextTheme = TextTheme();

final ThemeData defaultTheme = ThemeData.from(
  colorScheme: defaultColorScheme,
);
