import 'package:flutter/material.dart';

class OptionCardWidget extends StatelessWidget {
  const OptionCardWidget(
      {required this.name, required this.value, this.child, super.key});

  final String name;
  final Widget value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "$name: ",
                  style: TextStyle().copyWith(color: Colors.white),
                ),
                value,
              ],
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
