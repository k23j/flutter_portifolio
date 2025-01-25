import 'package:flutter/material.dart';
import 'package:flutter_portifolio/project_02-clock/clock_border.dart';
import 'package:flutter_portifolio/project_02-clock/clock_hand_widget.dart';
import 'package:flutter_portifolio/project_02-clock/clock_middle_pin.dart';
import 'package:flutter_portifolio/project_02-clock/clock_options.dart';
import 'package:flutter_portifolio/project_02-clock/clock_value_notifier.dart';
import 'package:flutter_portifolio/utils/math_helper.dart';

class ClockWidget extends StatelessWidget {
  final ClockValueNotifier _notifier;

  const ClockWidget(this._notifier, {super.key});

  final double clockSize = 550;

  double secondsToTurnFraction(DateTime dateTime) => dateTime.second / 60;

  double minutesToTurnFraction(DateTime dateTime) {
    int second = dateTime.second;
    int minuteInSeconds = dateTime.minute * 60;
    double totalSeconds = minuteInSeconds.toDouble() + second;

    double inDegree = totalSeconds / 60.0 * 360 / 60;
    return MathHelper.degreesToRadians(inDegree);
  }

  double hoursToTurnFraction(DateTime dateTime) {
    int second = dateTime.second;
    int minuteInSeconds = dateTime.minute * 60;
    int hoursInSeconds = dateTime.hour * 60 * 60;

    double totalSeconds = hoursInSeconds.toDouble() + minuteInSeconds + second;

    double inDegree = totalSeconds / 3600.0 * 30.0;

    return MathHelper.degreesToRadians(inDegree);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: clockSize,
            height: clockSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClockBorder(),
                //HourHand
                ClockHandWidget(
                  notifier: _notifier.hoursTurnNotifier,
                  dateTimeToTurnFraction: hoursToTurnFraction,
                  width: 15,
                  height: 145,
                ),
                //MinuteHand
                ClockHandWidget(
                  notifier: _notifier.minutesTurnNotifier,
                  dateTimeToTurnFraction: minutesToTurnFraction,
                  width: 15,
                  height: 235,
                ),
                //SecondsHand
                ClockHandWidget(
                  notifier: _notifier.secondsTurnNotifier,
                  dateTimeToTurnFraction: secondsToTurnFraction,
                  height: 225,
                  color: Colors.red,
                ),

                ClockMiddlePin(),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ClockOptions(_notifier)
        ],
      ),
    );
  }
}
