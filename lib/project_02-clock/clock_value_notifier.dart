import 'dart:async';

import 'package:flutter/material.dart';

class ClockValueNotifier {
  double _clockSpeed = 1;
  set clockSpeed(double value) {
    _clockSpeed = value;
    _startTimer();
  }

  double get clockSpeed => _clockSpeed;

  ClockValueNotifier() {
    _init();
  }

  final Duration _interval = Duration(milliseconds: 1000);

  final DateTime _startDateTime = DateTime.now();
  Timer? _timer;

  late final double _secondTickTurnValue = 1 / 60;
  late final double _minuteTickTurnValue = 1 / (60 * 60);
  late final double _hourTickTurnValue = 1 / (12 * 60 * 60);

  late ValueNotifier<double> secondsTurnNotifier;

  late ValueNotifier<double> minutesTurnNotifier;

  late ValueNotifier<double> hoursTurnNotifier;

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

  void _init() async {
    _setValues();
    clockSpeed = 1;
    _startTimer();
  }

  void _setValues() {
    secondsTurnNotifier = ValueNotifier<double>(_secondsStartRot);

    minutesTurnNotifier = ValueNotifier<double>(_minutesStartRot);

    hoursTurnNotifier = ValueNotifier<double>(_hoursStartRot);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: (_interval.inMilliseconds / _clockSpeed).round()),
      (timer) => _clockTick(),
    );
  }

  void resetClock() => _init();

  void _clockTick() {
    secondsTurnNotifier.value += _secondTickTurnValue;
    minutesTurnNotifier.value += _minuteTickTurnValue;
    hoursTurnNotifier.value += _hourTickTurnValue;
  }
}
