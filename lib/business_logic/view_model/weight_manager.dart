import 'package:flutter/material.dart';

import '../../model/weight_model.dart';

class WeightManager extends ChangeNotifier {

  int _selectedIndex = -1;
  Weight? _weight;

  int get index => _selectedIndex;

  void onChangeSelectedWeightItem(int index, Weight weight) {
    if(_selectedIndex == index || _weight == weight){
      return;
    }
    _selectedIndex = index;
    _weight = weight;
    notifyListeners();
  }
}