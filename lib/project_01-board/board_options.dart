import 'package:flutter/material.dart';
import 'package:flutter_portifolio/commom/option_card_widget.dart';
import 'package:flutter_portifolio/project_01-board/board_square.dart';

class BoardOptions extends StatefulWidget {
  const BoardOptions({
    super.key,
  });

  @override
  State<BoardOptions> createState() => _BoardOptionsState();
}

class _BoardOptionsState extends State<BoardOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OptionCardWidget(
          name: "Border Radius",
          value: Text(
            radiusValue.toStringAsFixed(2),
            style: TextStyle().copyWith(color: Colors.white),
          ),
          child: Slider(
            activeColor: Theme.of(context).colorScheme.onPrimary,
            thumbColor: Theme.of(context).colorScheme.onPrimary,
            value: radiusValue,
            onChanged: onRadiusChanged,
            min: 0,
            max: 10,
          ),
        )
      ],
    );
  }

  double radiusValue = 3;

  void onRadiusChanged(value) {
    setState(() {
      radiusValue = value;
    });
    BoardSquare.borderRadius = value;
  }
}
