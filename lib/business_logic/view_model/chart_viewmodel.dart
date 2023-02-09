import 'package:flutter/material.dart';

import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';
import '../../ui/views/chart_page.dart';
import '../../ui/views/home/home_page.dart';


class ChartViewModel extends ChangeNotifier {

  static const int WEEKLY = 7 ;
  static const int MONTHLY = 30 ;
  static const int QUATERLY = 90 ;
  static const int SEMI_ANNUALLY = 180 ;


  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];

  List<Weight> get weights => _weights;

  Periods get period => _period;

  Periods _period = Periods.weekly;

  bool isPeriodPickerSelected(Period selectedPeriod) =>
      _period == selectedPeriod;

  void togglePeriod(Periods selectedPeriod) {
    if (_period == selectedPeriod) {
      return;
    }
    _period = selectedPeriod;
    loadData();
  }

  Future<List<Weight>> loadDataBasedOnPeriod() async {
    switch (_period) {
      case Periods.semiAnnually:
        return loadDataWeightFrom180daysAgo();
      case Periods.quarterly:
        return loadDataWeightFrom90daysAgo();
      case Periods.monthly:
        return loadDataWeightFrom30daysAgo();
      case Periods.weekly:
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
    return _storageService.loadWeightFromDaysAgo(SEMI_ANNUALLY);
  }

  Future<List<Weight>> loadDataWeightFrom90daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(QUATERLY);
  }

  Future<List<Weight>> loadDataWeightFrom30daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(MONTHLY);
  }

  Future<List<Weight>> loadDataWeightFrom7daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(WEEKLY);
  }


}
