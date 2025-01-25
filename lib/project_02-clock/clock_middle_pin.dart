import 'package:flutter/material.dart';

class ClockMiddlePin extends StatelessWidget {
  const ClockMiddlePin({
    super.key,
  });

  final double size = 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
