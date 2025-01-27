import 'package:flutter/material.dart';

class PageTitleWidget extends StatelessWidget {
  final String title;

  const PageTitleWidget(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Theme.of(context).colorScheme.onSecondary),
    );
  }
}
