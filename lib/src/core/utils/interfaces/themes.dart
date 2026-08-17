import 'package:flutter/material.dart';

abstract class Themes {
  Color primary;
  Color light;
  Color surface;
  Color dark;
  Color accent;

  Themes({
    required this.primary,
    required this.light,
    required this.surface,
    required this.dark,
    required this.accent,
  });
}
