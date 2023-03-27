import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class EditViewModel extends BaseModel {
  final StorageService _storageService = serviceLocator<StorageService>();

  Weight? weight;
  int? index;

  late double _minimum;

  double get minimum => _minimum;
  late double _goal;

  double get goal => _goal;

  late DateTime _date;

  DateTime get date => _date;
  double _weightValue = 0.0;

  double get weightValue => _weightValue;


  EditViewModel({this.weight, this.index});

  void loadData() async {
    setBusy(true);
    await loadChartValue();
    loadWeight();
    loadDate();
    setBusy(false);
  }

  Future loadChartValue() async {
    _minimum = await _storageService.getMinWeightValue();
    print('edit_view_model | $_minimum');
    double goal = await _storageService.getGoal();
    if(goal <= _minimum){
      _goal = _minimum + 1;
    }else {
      _goal = goal;
    }
  }

  Future fetchMinimum() async {
    _minimum = await _storageService.getMinWeightValue();
  }

  Future fetchGoal() async {
    double goal = await _storageService.getGoal();
    if(goal < _minimum){
      _goal = _minimum + 1;
    }else {

      _goal = goal;
    }
  }

  void loadWeight() {
    if (weight == null) {
      _setWeight(0.0);
      return;
    }
    _setWeight(weight!.value);
  }

  void loadDate() {
    if(weight == null){
      _date = DateTime.now();
      return;
    }
    _date = weight!.dateEntry;
  }

  void _setWeight(double value) {
    _weightValue = value;

  }

  void pickWeight(String? value) {
    if (value == null) {
      return;
    }
    value = value.replaceAll(',', '.');
    print('edit_view_model | pickWeight | $value');
    _setWeight(double.parse(value));
    notifyListeners();
  }

  void pickDate(DateTime? dateTime) {
    if (dateTime != null) {
      _date = dateTime;
      notifyListeners();
    }
  }

}
