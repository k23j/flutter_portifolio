import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portifolio/main_section.dart';
import 'package:flutter_portifolio/left_section/portfolio_name.dart';
import 'package:flutter_portifolio/project_01-board/board.dart';
import 'package:flutter_portifolio/project_02-clock/clock_value_notifier.dart';
import 'package:flutter_portifolio/project_02-clock/clock_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int activeSection = -1;
  final double activeSectionWidthFactor = .6;

  final PageController _pageController = PageController(initialPage: 0);
  //1000 milliseconds == 1 second
  // final Duration animDuration = Duration(milliseconds: 300);

  late final AnimationController _animController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300));

  double leftSideWeight = .6;
  double rightSideWeight = .4;

  late final Tween<double> tween = Tween<double>(
      begin: leftSideWeight / rightSideWeight,
      end: rightSideWeight / leftSideWeight);

  late Animation<double> finalAnim;

  final ClockValueNotifier _clockValueNotifier = ClockValueNotifier();

  void setActiveSection(int id) {
    if (id == 1) {
      _animController.forward();
    } else {
      _animController.reverse();
    }

    setState(() {
      activeSection = id;
    });
  }

  void clearActiveSection() {
    _animController.animateTo(.5);
    setState(() {
      activeSection = -1;
    });
  }

  @override
  void initState() {
    _animController.value = .5;
    finalAnim = tween.animate(_animController);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedBuilder(
            animation: finalAnim,
            builder: (context, child) => MainSection(
              onMouseEnter: () => setActiveSection(0),
              onMouseExit: clearActiveSection,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              flex: (finalAnim.value * 1000).round(),
              child: child,
            ),
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
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            flex: 1000,
            child: Scrollbar(
              controller: _pageController,
              thumbVisibility: true,
              child: PageView(
                scrollDirection: Axis.vertical,
                pageSnapping: false,
                controller: _pageController,
                children: [
                  Board(),
                  ClockWidget(_clockValueNotifier),
                ],
              ),
            ),
            // child: ClockWidget(_clockValueNotifier),
            // child: Board(),
            // child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
