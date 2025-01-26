import 'package:flutter/material.dart';
import 'package:flutter_portifolio/commom/option_card_widget.dart';
import 'package:flutter_portifolio/project_02-clock/clock_value_notifier.dart';

class ClockOptions extends StatefulWidget {
  final ClockValueNotifier clockNotifier;

  const ClockOptions(this.clockNotifier, {super.key});

  @override
  State<ClockOptions> createState() => _ClockOptionsState();
}

class _ClockOptionsState extends State<ClockOptions>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int clockSpeedIndex = 2;
  List<double> clockSpeedList = [.25, .5, 1, 2, 5];
  double get selectedSpeed => clockSpeedList[clockSpeedIndex];

  void onSpeedChange(int id) {
    setState(() {
      clockSpeedIndex = id;
    });
  }

  void onSpeedChangeEnd(int id) {
    widget.clockNotifier.clockSpeed = selectedSpeed;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OptionCardWidget(
          name: 'Clock Speed',
          value: Text(
            selectedSpeed.toString(),
            style: TextStyle().copyWith(color: Colors.white),
          ),
          child: Slider(
            activeColor: Theme.of(context).colorScheme.onPrimary,
            thumbColor: Theme.of(context).colorScheme.onPrimary,
            value: clockSpeedIndex.toDouble(),
            onChanged: (value) => onSpeedChange(value.truncate()),
            onChangeEnd: (value) => onSpeedChangeEnd(value.truncate()),
            min: 0,
            max: clockSpeedList.length - 1,
          ),
        ),
      ],
    );
  }
}
