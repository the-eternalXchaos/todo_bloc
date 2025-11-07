import 'package:flutter/material.dart';

ThemeData appTheme() {
  final colorScheme = ColorScheme.light(
    surface: Colors.amber.shade100,
    onSurface: Colors.black,
    primary: Colors.amber,
    secondary: Colors.amberAccent,
    onSecondary: Colors.black,
  );

  return ThemeData(
    colorScheme: colorScheme,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onSurface,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
    ),
  );
}
