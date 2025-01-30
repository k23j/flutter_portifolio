import 'package:flutter/material.dart';
import 'dart:async';

class CountdownNotifier {
  late final ValueNotifier<Duration> durationNotifier;
  late final ValueNotifier<int> tickCountNotifier = ValueNotifier<int>(0);
  final Duration interval = Duration(seconds: 1);
  late final Timer timer;
  final void Function()? onEnd;

  CountdownNotifier(DateTime target, {this.onEnd}) {
    durationNotifier =
        ValueNotifier<Duration>(target.difference(DateTime.now()));
    init();
  }

  void init() async {
    final Duration offsetDuration = Duration(
        milliseconds: durationNotifier.value.inMilliseconds.remainder(1000));
    await Future.delayed(offsetDuration);
    durationNotifier.value -= offsetDuration;
    timer = Timer.periodic(interval, (timer) => tick());
  }

  void tick() {
    durationNotifier.value -= interval;
    tickCountNotifier.value += 1;
    if (durationNotifier.value <= Duration.zero) finish();
  }

  void finish() {
    timer.cancel();
    onEnd?.call();
  }
}
