import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:weight_app/business_logic/helpers/weight_filters.dart';
import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/periods.dart';
import '../../model/weight_model.dart';
import '../utils/constants.dart';


/*
    1) LoadData with empty list  Is it necessary ??
    2) UpdateData(List<Weight> weights)
      a) Do we need this list elsewhere ? YES, if we need to change periods we also need all available weight to filter that
        #) Can we ask one more time WeightModel for data or used previous one ?
    3) Before build, we have to create _spots based on _weights
      a) Maybe not, b/c build is made before update call ( I think so )
      b) We have to only notify about updating #stateSource
    4) Weight_Chart is based on weights so we have to also filter a think

 */

class ChartsModel extends BaseModel {

  List<Weight> _weights = [];

  List<Weight> _filteredWeights = [];

  List<Weight> get filteredWeights => _filteredWeights;

  List<FlSpot> _spots = [];

  List<FlSpot> get spots => _spots;

  Periods get period => _period;

  Periods _period = Periods.weekly;

  late double _diff = 0;

  double get diff => _diff;

  void loadData(List<Weight> weights) {

    if(weights.isEmpty){
      return;
    }
    setBusy(true);
    _weights = WeightModel.sortByDate(weights);
    transformData();
    setBusy(false);
  }

  void transformData() async {
    print('charts_model | transformData | weights.len: ${_weights.length}');
    List<Weight> filteredWeights = WeightFilters.filterDataBasedOnPeriod(_period,_weights);
    print('charts_model | transformData | filtered.len: ${filteredWeights.length}');

    // This list I should set as get for _weights !
    List<Weight> weightsNoRepetition = joinRepeatedWeightDate(filteredWeights);
    print('charts_model | transformData | noRep.len: ${weightsNoRepetition.length}');
    _filteredWeights = weightsNoRepetition;
    _spots = convertToDaysFlSpot(weightsNoRepetition);
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

  List<FlSpot> convertToDaysFlSpot(List<Weight> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      spots.add(FlSpot(i.toDouble(), weights[i].value.floorToDouble()));
    }
    return spots.toSet().toList();
  }

  void _sortFlSpots() {
    _spots.sort((a, b) => a.x.compareTo(b.x));
  }

  double countDiff() => getMaxWeightValue() - getMinWeightValue();

  void togglePeriod(Periods selectedPeriod) async {
    if (_period == selectedPeriod) {
      return;
    }
    _period = selectedPeriod;
    transformData();
    notifyListeners();
  }

  bool isPeriodPickerSelected(Periods selectedPeriod) =>
      _period == selectedPeriod;

  bool shouldDisplayChart() {
    print('charts_model | shouldDisplayChart | ${_weights.isNotEmpty}');
    return _filteredWeights.isNotEmpty;
  }

  double getMinWeightValue() {

    List<double> ySpots = [];
    for (var spot in _spots) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(min);
  }

  double getMaxWeightValue() {

    List<double> ySpots = [];
    for (var spot in _spots) {
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
    if (_spots.length <= 3) {
      return 1;
    }
    return (_spots.length - 1) / 2;
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

  double countMinX() => 0;

  double countMaxX() => _spots.length - 1;

}
