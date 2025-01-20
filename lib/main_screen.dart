import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portifolio/main_section.dart';
import 'package:flutter_portifolio/left_section/portfolio_name.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int activeSection = -1;
  final double activeSectionWidthFactor = .6;
  //1000 milliseconds == 1 second
  final Duration animDuration = Duration(milliseconds: 300);
  final int flexBaseValue = 1000;

  double get tweenAnimTargetValue {
    switch (activeSection) {
      case 0:
        return -1.0;
      case 1:
        return 1.0;
      default:
        return 0.0;
    }
  }

  int convertValueToFlex(double value) {
    double alpha = (value + 1) / 2;
    return lerpDouble(flexBaseValue - activeSectionWidthFactor * flexBaseValue,
            activeSectionWidthFactor * flexBaseValue, alpha)!
        .toInt();
  }

  void setActiveSection(int id) {
    setState(() {
      activeSection = id;
    });
  }

  void clearActiveSection() {
    setState(() {
      activeSection = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: tweenAnimTargetValue),
        curve: Curves.easeInOut,
        duration: animDuration,
        builder: (context, value, child) => Row(
          children: [
            MainSection(
              onMouseEnter: () => setActiveSection(0),
              onMouseExit: clearActiveSection,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              flex: flexBaseValue - convertValueToFlex(value),
              child: Padding(
                padding: const EdgeInsets.only(top: 64),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: PortfolioName(
                    highlight: activeSection == 0,
                  ),
                ),
              ),
            ),
            MainSection(
                onMouseEnter: () => setActiveSection(1),
                onMouseExit: clearActiveSection,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                flex: convertValueToFlex(value)),
          ],
        ),
      ),
    );
  }
}
