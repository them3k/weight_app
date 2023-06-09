// provider jest tylk dostępny w contexcie
// spróbwać utworzyć service, który jest niezależny od danych

/*

	* are normal Dart classes that are written to do some specialized task in your app.
	The purpose of a service is to isolate a task, especially volatile third-party packages,
	and hide its implementation details from the rest of the app.


 */

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/business_logic/utils/constants.dart';
import 'package:weight_app/services/chart_service/chart_service.dart';
import 'package:weight_app/ui/widget/fl_chart_line_widget.dart';

import '../../model/chart.dart';
import '../../model/periods.dart';
import '../../model/weight_model.dart';

/*
Services
	*
are normal Dart classes that are written to do some specialized task in your app.
The purpose of a service is to isolate a task, especially volatile third-party packages,
and hide its implementation details from the rest of the app.
 */

class ChartServiceImpl extends ChartService {
  late double _diff;

  double get diff => _diff;

  late List<FlSpot> _spots;
  late double _bottomTitleInterval;
  late double _rightTitleInterval;

  double get rightTitleInterval => _rightTitleInterval;

  late double _minX;
  late double _maxX;

  late double _minY;
  double get minY => _minY;

  late double _maxY;
  late bool isFirstValue;

  late Periods _period;

  late DateTime _now;

  @override
  Future<Chart> fetchDataChart(List<Weight> weights, DateTime now, Periods period) async{
    _period = period;
    _now = now;
    _minX = countMinX();
    _maxX = countMaxX();
    _spots = createSpots(weights);
    _diff = countDiff();
    _bottomTitleInterval = countBottomTitleInterval();
    _rightTitleInterval = countRightTitleInterval();
    _minY = countMinY();
    _maxY = countMaxY();
    return Chart(
      spots: _spots,
      now: now,
      weights: weights,
      bottomTitleInterval: _bottomTitleInterval,
      rightTitleInterval: _rightTitleInterval,
      diff: _diff,
      minX: _minX,
      maxX: _maxX,
      minY: _minY,
      maxY: _maxY,
      isFirstValue: _spots.length == 1
    );
  }

  @override
  List<FlSpot> createSpots(List<Weight> weights) {
    print('chart_service_impl | createSpots');
    _spots = convertDataChartFlSpots(weights);
    return sortFlSpots(_spots);
  }

  List<FlSpot> convertDataChartFlSpots(List<Weight> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      double differenceInDaysFromToday = _now.difference(weights[i].dateEntry).inDays.toDouble();
      print('chart_service_impl | differenceInDaysFromToday: $differenceInDaysFromToday');
      spots.add(FlSpot(_maxX.toInt() - differenceInDaysFromToday, weights[i].value));
    }
    return spots.toSet().toList();
  }


  List<FlSpot> sortFlSpots(List<FlSpot> spots) {
    return spots..sort((a, b) => a.x.compareTo(b.x));
  }

  @override
  double countDiff() {
    _diff = getMaxWeightValue() - getMinWeightValue();
    return _diff;
  }

  @override
  double getMinWeightValue() {

    List<double> ySpots = [];
    for (var spot in _spots) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(min);
  }

  @override
  double getMaxWeightValue() {

    List<double> ySpots = [];
    for (var spot in _spots) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(max);
  }

  @override
  double countRightTitleInterval() {

    if (_diff >= 105) {
      return 50;
    }

    if (_diff >= 74) {
      return 30;
    }

    if (_diff >= 44) {
      return 20;
    }

    if (_diff >= 16) {
      return 10;
    }

    if (_diff >= 13) {
      return 5;
    }

    if (_diff >= 10) {
      return 4;
    }

    if (_diff >= 7) {
      return 3;
    }

    if (_diff >= 4) {
      return 2;
    }

    return 1;

  }

  @override
  double countBottomTitleInterval() {

    switch(_period){
      case Periods.weekly:
        return 1;
      case Periods.monthly:
        return 10;
      case Periods.quarterly:
        return 30;
      case Periods.semiAnnually:
        return 60;
    }
  }

  @override
  double countMaxY() {
    double max = getMaxWeightValue();
    double interval = countRightTitleInterval();

    if (_diff >= 0 && _diff < 1) {
      return max.truncateToDouble() + 1;
    }

    if (isDivisible(max, interval)) {
      return (max += interval).toDouble();
    }

    return (max ~/ interval * interval) + interval;
  }

  @override
  double countMinY() {
    double min = getMinWeightValue();
    double interval = countRightTitleInterval();

    if (min - interval <= 0) {
      return 0;
    }

    if (_diff >= 0 && _diff < 1) {
      return min.truncateToDouble();
    }

    if (isDivisible(min, interval)) {
      return (min -= interval).toDouble();
    }

    return (min ~/ interval * interval) - interval;
  }

  @override
  bool isDivisible(double dividend, double divider) {
    return dividend % divider == 0;
  }

  @override
  double countMinX() => 0;

  @override
  double countMaxX() {
    switch(_period){
      case Periods.weekly:
        return Constants.WEEKLY - 1;
      case Periods.monthly:
        return Constants.MONTHLY -1;
      case Periods.quarterly:
        return Constants.QUATERLY -1;
      case Periods.semiAnnually:
        return Constants.SEMI_ANNUALLY -1;
    }
  }
}