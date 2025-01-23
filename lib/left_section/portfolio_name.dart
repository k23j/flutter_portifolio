import 'package:flutter/material.dart';

class PortfolioName extends StatelessWidget {
  final bool highlight;

  final Duration duration = const Duration(milliseconds: 100);

  const PortfolioName({
    this.highlight = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .75, end: highlight ? 1.0 : .75),
      duration: duration,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: Text(
        'Passos',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha(164),
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ]),
      ),
    );
  }
}
