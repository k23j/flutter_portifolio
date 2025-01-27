import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portifolio/commom/page_title_widget.dart';
import 'package:flutter_portifolio/commom/project_widget.dart';
import 'package:flutter_portifolio/main_section.dart';
import 'package:flutter_portifolio/left_section/portfolio_name.dart';
import 'package:flutter_portifolio/project_01-board/board.dart';
import 'package:flutter_portifolio/project_02-clock/clock_value_notifier.dart';
import 'package:flutter_portifolio/project_02-clock/clock_widget.dart';
import 'package:flutter_portifolio/sidebar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final List<ProjectWidget> projectWidgetList = [
    ProjectWidget("Wave Board", (context) => Board()),
    ProjectWidget(
        "Analog Clock", (context) => ClockWidget(_clockValueNotifier)),
  ];

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

  int _numOfPages = 0;
  int currentPage = 0;
  final Duration nextPageAnimDuration = Duration(milliseconds: 300);
  final Curve nextPageAnimCurve = Curves.easeInOut;

  void viewNextProject() {
    _pageController.nextPage(
        duration: nextPageAnimDuration, curve: nextPageAnimCurve);
    onPageChange(_pageController.page!.floor() + 1);
  }

  void viewPreviusProject() {
    _pageController.previousPage(
        duration: nextPageAnimDuration, curve: nextPageAnimCurve);
    onPageChange(_pageController.page!.round() - 1);
  }

  void changeToProject(int index) {
    // _pageController.jumpToPage(index);
    _pageController.animateToPage(index,
        duration: nextPageAnimDuration, curve: nextPageAnimCurve);
    onPageChange(index);
    // _pageController.animateTo(index.toDouble(),
    //     duration: nextPageAnimDuration, curve: nextPageAnimCurve);
    // onPageChange(index);
  }

  bool _isOnLastPage = false;
  bool _isOnFirstPage = true;
  void onPageChange(int changeTo) {
    setState(() {
      currentPage = changeTo;
      _isOnFirstPage = changeTo == 0;
      _isOnLastPage = changeTo == _numOfPages - 1;
    });
  }

  @override
  void initState() {
    _animController.value = .5;
    _numOfPages = projectWidgetList.length;
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
            child: Stack(
              children: [
                PageView(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  controller: _pageController,
                  children:
                      projectWidgetList.map((e) => e.builder(context)).toList(),
                ),
                Positioned(
                    top: 16,
                    left: 16,
                    child:
                        PageTitleWidget(projectWidgetList[currentPage].title)),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Sidebar(currentPage,
                      projectWidgetList.map((e) => e.title).toList(),
                      onChangePage: changeToProject),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(
                    children: [
                      //Go to previus page
                      Opacity(
                        opacity: _isOnFirstPage ? .5 : 1,
                        child: FloatingActionButton(
                          onPressed:
                              (_isOnFirstPage) ? null : viewPreviusProject,
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      //Go to next page
                      Opacity(
                        opacity: _isOnLastPage ? .5 : 1,
                        child: FloatingActionButton(
                          onPressed: (_isOnLastPage) ? null : viewNextProject,
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
