import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/base_model.dart';

import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/periods.dart';
import '../../model/weight_model.dart';
import '../utils/constants.dart';


class ChartsModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];

  List<Weight> get weights => _weights;

  List<FlSpot> _spots = [];

  List<FlSpot> get spots => _spots;

  Periods get period => _period;

  Periods _period = Periods.weekly;

  late double _diff = 0;

  double get diff => _diff;

  bool isPeriodPickerSelected(Periods selectedPeriod) =>
      _period == selectedPeriod;

  void togglePeriod(Periods selectedPeriod) {
    print('charts_model_ | togglePeriod ');
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

  Future fetchWeights() async {
    _weights = await loadDataBasedOnPeriod();
  }

  bool shouldDisplayChart() {
    return _weights.isNotEmpty;
  }

  void loadData() async {
    setBusy(true);
    print('ChartsModel | loadData');
    await fetchWeights();
    if(shouldDisplayChart()) {
      transformData();
    }
    setBusy(false);
  }

  void transformData() {
    _spots = convertToDaysFlSpot();
    _sortFlSpots();
    _diff = countDiff();
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
    return _storageService.loadWeightFromDaysAgo(Constants.SEMI_ANNUALLY);
  }

  Future<List<Weight>> loadDataWeightFrom90daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(Constants.QUATERLY);
  }

  Future<List<Weight>> loadDataWeightFrom30daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(Constants.MONTHLY);
  }

  Future<List<Weight>> loadDataWeightFrom7daysAgo() async {
    return _storageService.loadWeightFromDaysAgo(Constants.WEEKLY);
  }

  List<FlSpot> convertToDaysFlSpot() {
    List<FlSpot> spots = [];
    for (int i = 0; i < _weights.length; i++) {
      spots.add(FlSpot(i.toDouble(), _weights[i].value.floorToDouble()));
    }
    return spots.toSet().toList();
  }

  void _sortFlSpots() {
    if(_spots == null){
      return;
    }
    _spots!.sort((a, b) => a.x.compareTo(b.x));
  }

  double countDiff() =>
      getMaxWeightValue() - getMinWeightValue();

  double getMinWeightValue() {

    if(_spots == null) {
      return 0;
    }

    List<double> ySpots = [];
    for (var spot in _spots!) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(min);
  }

  double getMaxWeightValue() {

    if(_spots == null){
      return 0;
    }
    List<double> ySpots = [];
    for (var spot in _spots!) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(max);
  }


  double countRightTitleInterval() {
    if (_diff >= 0 && _diff <= 4) {
      return 1;
    }

    if (_diff >= 5 && _diff <= 7) {
      return 2;
    }

    if (_diff >= 8 && _diff <= 10) {
      return 3;
    }

    if (_diff >= 11 && _diff <= 13) {
      return 4;
    }

    if (_diff >= 14 && _diff <= 16) {
      return 5;
    }

    if (_diff >= 17 && _diff <= 44) {
      return 10;
    }

    if (_diff >= 45 && _diff <= 74) {
      return 20;
    }

    if (_diff >= 75 && _diff <= 104) {
      return 30;
    }

    if (_diff >= 105) {
      return 50;
    }

    return 1;
  }

  double countBottomTitleInterval() {
    if (_weights.length <= 3) {
      return 1;
    }
    return (_weights.length - 1) / 2;
  }

  double countMaxY() {

    double max = getMaxWeightValue();
    double interval = countRightTitleInterval();

    if (isDivisible(max, interval)) {
      return (max += interval).toDouble();
    }

    return (max ~/ interval * interval) + interval;
  }

  double countMinY() {

    double min = getMinWeightValue();
    double interval = countRightTitleInterval();

    if (min - interval <= 0) {
      return 0;
    }

    if (isDivisible(min, interval)) {
      return (min -= interval).toDouble();
    }

    return (min ~/ interval * interval) - interval;
  }

  bool isDivisible(double dividend, double divider) {
    return dividend % divider == 0;
  }

  double? countMinX() {
    return 0;
  }

  double? countMaxX() {
    return _weights.length - 1;
  }


}
