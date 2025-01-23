import 'package:flutter/material.dart';
import 'package:flutter_portifolio/utils/random_color.dart';
import 'package:flutter_portifolio/utils/vector_2d.dart';

class BoardSquare extends StatefulWidget {
  final Vector2d id;
  final Function(Vector2d id) onClick;
  const BoardSquare(
    this.id, {
    required this.onClick,
    super.key,
  });

  @override
  State<BoardSquare> createState() => BoardSquareState();
}

class BoardSquareState extends State<BoardSquare>
    with TickerProviderStateMixin {
  bool isActive = false;
  bool isFirstBuild = true;
  late final Color highlightColor;
  final Duration fadeAnimDuration = Duration(milliseconds: 1000);
  late final AnimationController _fadeAnimcontroller;

  void setActive() {
    _fadeAnimcontroller.value = 0;
    setState(() {
      isActive = true;
    });
  }

  void reset() {
    _fadeAnimcontroller.forward();
    setState(() {
      isActive = false;
    });
  }

  final double minSize = .7;
  final double maxSize = .9;
  final Duration growAnimDuration = Duration(milliseconds: 400);
  late final TweenSequence<double> growAnimTween = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween<double>(begin: minSize, end: maxSize), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: maxSize, end: minSize), weight: 1)
  ]);

  late final AnimationController _growAnimcontroller;
  late final Animation<double> growAnimation;

  void playGrowAnim() {
    // growAnimTween.animate(_growAnimcontroller);
    _growAnimcontroller.forward(from: 0);
    setActive();
    reset();
  }

  @override
  void initState() {
    highlightColor = RandomColor.random();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => isFirstBuild = false,
    );

    _fadeAnimcontroller =
        AnimationController(vsync: this, duration: fadeAnimDuration, value: 1);
    _growAnimcontroller =
        AnimationController(vsync: this, duration: growAnimDuration, value: 0);
    growAnimation = growAnimTween.animate(_growAnimcontroller);

    super.initState();
  }

  @override
  void dispose() {
    _fadeAnimcontroller.dispose();
    _growAnimcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
        Theme.of(context).colorScheme.tertiary.withAlpha(100);

    return GestureDetector(
      onTap: () => widget.onClick(widget.id),
      child: MouseRegion(
        onEnter: (_) => setActive(),
        onExit: (_) => reset(),
        child: AnimatedBuilder(
          animation: growAnimation,
          builder: (context, child) => Transform.scale(
            scale: growAnimation.value,
            child: child,
          ),
          child: AnimatedBuilder(
            animation: _fadeAnimcontroller,
            builder: (context, child) => Container(
              decoration: BoxDecoration(
                color: Color.lerp(
                    highlightColor, defaultColor, _fadeAnimcontroller.value),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
