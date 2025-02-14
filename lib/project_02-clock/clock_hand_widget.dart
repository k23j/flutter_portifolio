import 'package:flutter/material.dart';

class ClockHandWidget extends StatelessWidget {
  final ValueNotifier<double> notifier;
  final double Function(DateTime dateTime) dateTimeToTurnFraction;

  final double width;
  final double height;
  final Color color;

  final Curve? animCurve;
  static final Curve curve = Curves.easeInOut;

  final Widget? child;

  const ClockHandWidget({
    required this.notifier,
    required this.dateTimeToTurnFraction,
    this.child,
    this.width = 10,
    this.height = 250,
    this.color = Colors.black,
    this.animCurve,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Duration animDuration = Duration(milliseconds: 250);
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return AnimatedRotation(
          turns: value,
          curve: animCurve ?? curve,
          duration: animDuration,
          child: SizedBox(
            width: height * 1.8,
            height: height * 1.8,
            child: Align(
              alignment: Alignment.topCenter,
              child: (child != null)
                  ? child
                  : Container(
                      width: width,
                      height: height,
                      color: color,
                    ),
            ),
          ),
        );
      },
    );
  }
}
