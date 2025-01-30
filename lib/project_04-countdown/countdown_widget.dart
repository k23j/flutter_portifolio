import 'package:flutter/material.dart';
import 'package:flutter_portifolio/project_04-countdown/countdown_notifier.dart';
import 'package:flutter_portifolio/utils/math_helper.dart';

class CountdownWidget extends StatelessWidget {
  final DateTime target;

  const CountdownWidget(
    this.target, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CountdownNotifier notifier = CountdownNotifier(target);
    final Color backgroundColor =
        Theme.of(context).colorScheme.primaryContainer;
    return Center(
      child: Container(
        padding: EdgeInsets.all(12),
        clipBehavior: Clip.hardEdge,
        width: 700,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                backgroundColor,
                Color.lerp(backgroundColor, Colors.black, .3)!,
              ]),
        ),
        child: ValueListenableBuilder(
          valueListenable: notifier.durationNotifier,
          builder: (context, value, child) {
            final int days = value.inDays;
            final int hours = value.inHours.remainder(24);
            final int minutes = value.inMinutes.remainder(60);
            final int seconds = value.inSeconds.remainder(60);

            return Stack(
              children: [
                Positioned(
                  left: 32,
                  top: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Formatura \nC-Esp-HabSG',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                      Text('05/06/2025',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white.withValues(alpha: .6),
                                  fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 0,
                  bottom: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountdownRemainingText(title: "Dias", value: days),
                      CountdownRemainingText(title: "Horas", value: hours),
                      CountdownRemainingText(title: "Minutos", value: minutes),
                      CountdownRemainingText(title: "Segundos", value: seconds),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    right: 250,
                    child: Transform.scale(
                      scaleX: 1.5,
                      child: Icon(
                        Icons.trending_flat,
                        color: Colors.deepOrange,
                        size: 40,
                      ),
                    )),
                CountdownSideClock(notifier.tickCountNotifier),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CountdownSideClock extends StatelessWidget {
  final ValueNotifier<int> notifier;

  const CountdownSideClock(
    this.notifier, {
    super.key,
  });

  final int qnt = 64;
  final double size = 1300;
  double get angle => 360.0 / qnt;
  double get angleInTurns => 1.0 / qnt;

  List<Widget> generateMarkList() {
    return List.generate(
        qnt,
        (index) => Transform.rotate(
            angle: MathHelper.degreesToRadians(angle * index - 90),
            child: Align(
              alignment: Alignment(0, -.935),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                width: 2,
                height: 35,
              ),
            ))).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> makerList = generateMarkList();
    final Duration duration = Duration(milliseconds: 500);
    final Curve curve = Curves.elasticInOut;
    return OverflowBox(
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      alignment: Alignment.centerRight,
      child: Transform.translate(
        offset: Offset(size - 250, 0),
        child: Stack(
          children: [
            Transform.scale(
              scale: .95,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      Colors.black,
                      Colors.black.withValues(alpha: .5)
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, value, child) => AnimatedRotation(
                    duration: duration,
                    curve: curve,
                    turns: angleInTurns * value * -1,
                    child: child),
                child: Stack(
                  alignment: Alignment.center,
                  // clipBehavior: Clip.hardEdge, // Ensure nothing gets clipped
                  children: makerList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountdownRemainingText extends StatelessWidget {
  const CountdownRemainingText({
    super.key,
    required this.title,
    required this.value,
  });

  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
          Text(title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white.withValues(alpha: .6),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
