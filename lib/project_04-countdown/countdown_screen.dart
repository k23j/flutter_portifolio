import 'package:flutter/material.dart';
import 'package:flutter_portifolio/project_04-countdown/countdown_widget.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CountdownWidget(DateTime.utc(2025, 6, 5, 10, 0, 0));
  }
}
