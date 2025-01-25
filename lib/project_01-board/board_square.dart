import 'package:flutter/material.dart';

class BoardSquare extends ChangeNotifier {
  // static late final BoardSquare instance;

  // BoardSquare() {
  //   instance = BoardSquare();
  // }

  static final ValueNotifier<double> borderRadiusNotifier =
      ValueNotifier<double>(3);

  static set borderRadius(double value) {
    borderRadiusNotifier.value = value;
    borderRadiusNotifier.notifyListeners();
  }
}
