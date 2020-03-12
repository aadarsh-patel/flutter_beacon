import 'package:flutter/material.dart';

LinearGradient myGradient = LinearGradient(
  colors: [
    Colors.blue.withOpacity(0.4),
    Colors.white,
    Colors.blue.withOpacity(0.2)
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
