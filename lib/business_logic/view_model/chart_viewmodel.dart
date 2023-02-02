import 'package:flutter/material.dart';

import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/hive/models/weight.dart';
import '../../model/weight_model.dart';
import '../../ui/views/chart_page.dart';


class ChartViewModel extends ChangeNotifier {
  static const int SIX_MONTHS_IN_DAYS = 180;
  static const int THREE_MONTHS_IN_DAYS = 90;
  static const int THIRTY_DAYS = 30;
  static const int SEVEN_DAYS = 7;

  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];

  List<Weight> get weights => _weights;

  Period get period => _period;

  Period _period = Period.days7;

  bool isPeriodPickerSelected(Period selectedPeriod) =>
      _period == selectedPeriod;

  void togglePeriod(Period selectedPeriod) {
    if (_period == selectedPeriod) {
      return;
    }
    _period = selectedPeriod;
    loadData();
  }

  Future<List<Weight>> loadDataBasedOnPeriod() async {
    switch (_period) {
      case Period.days180:
        return loadDataWeightFrom180daysAgo();
      case Period.days90:
        return loadDataWeightFrom90daysAgo();
      case Period.days30:
        return loadDataWeightFrom30daysAgo();
      case Period.days7:
        return loadDataWeightFrom7daysAgo();
      default:
        return [];
    }
  }

  void loadData() async {
    _weights = joinRepeatedWeightDate( await loadDataBasedOnPeriod());
    notifyListeners();
  }

  List<Weight> joinRepeatedWeightDate(List<Weight> list) {
    Map<DateTime, double> weightMap = {};

    for (var element in list) {
      DateTime key = element.dateEntry;
      if (weightMap.containsKey(key) && weightMap[key] != null) {
        weightMap[key] = (weightMap[key]! + element.value) / 2;
      } else {
        weightMap[key] = element.value;
      }
    }

    return weightMap.entries
        .map((e) => Weight(value: e.value, dateEntry: e.key))
        .toList();
  }

  Future<List<Weight>> loadDataWeightFrom180daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(SIX_MONTHS_IN_DAYS);
  }

  Future<List<Weight>> loadDataWeightFrom90daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(THREE_MONTHS_IN_DAYS);
  }

  Future<List<Weight>> loadDataWeightFrom30daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(THIRTY_DAYS);
  }

  Future<List<Weight>> loadDataWeightFrom7daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(SEVEN_DAYS);
  }


}
