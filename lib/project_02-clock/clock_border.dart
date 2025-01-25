import 'package:flutter/material.dart';
import 'package:flutter_portifolio/utils/math_helper.dart';

class ClockBorder extends StatelessWidget {
  const ClockBorder({
    super.key,
  });

  List<Widget> get secondsMarker {
    return List<Widget>.generate(
      60,
      (index) => Transform.rotate(
        angle: MathHelper.degreesToRadians(360.0 / 60 * index),
        child: Align(
          alignment: Alignment(0, -.935),
          child: ClockBorderMarker(index % 5 == 0),
        ),
      ),
    );
  }

  List<Widget> hourNumbers(BuildContext context) {
    double degreeOffset = -90;
    double offset = 190;
    String indexToHourNumber(int id) {
      if (id == 0) return 12.toString();

      return id.toString();
    }

    return List<Widget>.generate(
      12,
      (index) => Transform.translate(
        offset: Offset.fromDirection(
            MathHelper.degreesToRadians(index * 360 / 12 + degreeOffset),
            offset),
        child: Text(
          indexToHourNumber(index),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        decoration: ShapeDecoration(
          color: Colors.white54,
          shape: CircleBorder(
            side: BorderSide(color: Colors.black, width: 10),
          ),
        ),
      ),
      ...secondsMarker,
      ...hourNumbers(context),
    ]);
  }
}

class ClockBorderMarker extends StatelessWidget {
  final bool isHour;

  const ClockBorderMarker(
    this.isHour, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHour ? 12 : 8,
      height: isHour ? 30 : 25,
      color: isHour ? Colors.black : Colors.black26,
    );
  }
}
