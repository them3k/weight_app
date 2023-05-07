import 'package:flutter/material.dart';

class WeightManager extends ChangeNotifier {

  int _selectedIndex = -1;

  int get index => _selectedIndex;

  void onChangeSelectedIndex(int index) {
    if(_selectedIndex == index){
      return;
    }
    _selectedIndex = index;
    notifyListeners();
  }
}