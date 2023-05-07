import 'package:flutter/material.dart';

import '../../model/weight_model.dart';

class WeightManager extends ChangeNotifier {

  int? _selectedIndex = -1;
  Weight? _weight;

  int? get index => _selectedIndex;
  Weight? get weight => _weight;

  void onChangeSelectedWeightItem([int? index, Weight? weight]) {
    _selectedIndex = index;
    _weight = weight;
    notifyListeners();
  }
}