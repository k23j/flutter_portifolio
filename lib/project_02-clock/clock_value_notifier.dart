import 'dart:async';

import 'package:flutter/material.dart';

class ClockValueNotifier {
  double _clockSpeed = 1;
  set clockSpeed(double value) {
    _clockSpeed = value;
    startTimer();
  }

  ClockValueNotifier() {
    init();
  }

  final Duration _interval = Duration(milliseconds: 1000);

  final DateTime _startDateTime = DateTime.now();
  Timer? _timer;

  late final double _secondTickTurnValue = 1 / 60;
  late final double _minuteTickTurnValue = 1 / (60 * 60);
  late final double _hourTickTurnValue = 1 / (12 * 60 * 60);

  late final ValueNotifier<double> secondsTurnNotifier =
      ValueNotifier<double>(_secondsStartRot);

  late final ValueNotifier<double> minutesTurnNotifier =
      ValueNotifier<double>(_minutesStartRot);

  late final ValueNotifier<double> hoursTurnNotifier =
      ValueNotifier<double>(_hoursStartRot);

  double get _secondsStartRot {
    return _startDateTime.second * _secondTickTurnValue;
  }

  double get _minutesStartRot {
    return (_startDateTime.second + _startDateTime.minute * 60) *
        _minuteTickTurnValue;
  }

  double get _hoursStartRot {
    int totalSeconds = (_startDateTime.hour % 12) * 60 * 60 +
        _startDateTime.minute * 60 +
        _startDateTime.second;
    return totalSeconds * _hourTickTurnValue;
  }

  void init() async {
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: (_interval.inMilliseconds / _clockSpeed).round()),
      (timer) => clockTick(),
    );
  }

  void clockTick() {
    secondsTurnNotifier.value += _secondTickTurnValue;
    minutesTurnNotifier.value += _minuteTickTurnValue;
    hoursTurnNotifier.value += _hourTickTurnValue;
  }
}
