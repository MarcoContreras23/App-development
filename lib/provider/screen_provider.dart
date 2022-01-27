import 'package:flutter/material.dart';

class ScreenCurrent with ChangeNotifier {

  int _current = 0;

  get current{
    return _current;
  }

  set screen (int value){
    this._current = value;
    notifyListeners();
  }
}