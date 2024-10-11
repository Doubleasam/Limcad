import 'package:flutter/material.dart';

abstract class BaseVM extends ChangeNotifier {
  bool _busy = false;
  bool get loading => _busy;

  void isLoading(bool value) {
    _busy = value;
    notifyListeners();
  }
}