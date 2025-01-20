import 'package:flutter/material.dart';

//This should Aways be put inside a flex container (row, column)
class MainSection extends StatelessWidget {
  final Color backgroundColor;
  final int flex;
  final Widget? child;

  final void Function()? onMouseEnter;
  final void Function()? onMouseExit;

  const MainSection({
    required this.backgroundColor,
    required this.flex,
    this.onMouseEnter,
    this.onMouseExit,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: MouseRegion(
        onEnter: (event) => onMouseEnter?.call(),
        onExit: (event) => onMouseExit?.call(),
        child: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: child,
        ),
      ),
    );
  }
}
