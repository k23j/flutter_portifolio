import 'package:flutter/material.dart';

final ColorScheme defaultColorScheme =
    ColorScheme.fromSeed(seedColor: const Color(0xFF495F73)).copyWith(
  primaryContainer: const Color(0xFF495F73),
  secondaryContainer: const Color(0xFFBACBD9),
  onPrimary: const Color(0xFFE0E0E0),
  onSecondary: const Color(0xFF1A2E3B),
);

final TextTheme defaultTextTheme = TextTheme();

final ThemeData defaultTheme = ThemeData.from(
  colorScheme: defaultColorScheme,
);
