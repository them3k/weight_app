import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:weight_app/business_logic/helpers/weight_filters.dart';
import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import '../../model/chart.dart';
import '../../model/periods.dart';
import '../../model/weight_model.dart';
import '../../services/chart_service/chart_service.dart';

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

  Periods get period => _period;

  Periods _period = Periods.weekly;

  final DateTime now = DateTime.now();

  late Chart _chartData;

  Chart get chartData => _chartData;

  final ChartService _chartService = serviceLocator<ChartService>();

  void loadData(List<Weight> weights) async {


    print('charts_model | loadData | weights: ${weights.length}');
    setBusy(true);
    _weights = weights;
    await createChart();
    setBusy(false);
  }

  Future createChart() async {
    print('charts_model | createCharts');
    filterDataByPeriod();
    removeRepetition();
    sortByDate();
    fetchChartData();
  }

  void filterDataByPeriod() {
    print('charts_model | filterDataByPeriod() ');
    _filteredWeights = WeightFilters.filterDataBasedOnPeriod(_period, _weights);
    print('charts_model | filterDataByPeriod() | $_filteredWeights ');
  }

  void removeRepetition() {
    print('charts_model | removeRepetition');
    List<Weight> noRepetiton = WeightFilters.removeRepetitions(_filteredWeights);
    _filteredWeights = noRepetiton;
    print('charts_model | removeRepetition | $_filteredWeights');
  }

  void sortByDate() {
    _filteredWeights.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));
  }

  Future fetchChartData() async {
    print('charts_model | fetchChartData | filteredWeights: ${_filteredWeights.length}');
    if(_filteredWeights.isEmpty) {
      return;
    }
    _chartData = await _chartService.fetchDataChart(_filteredWeights, now);
    print('charts_model | fetchChartData | ${chartData}');

  }

  void togglePeriod(Periods selectedPeriod) async {
    if (_period == selectedPeriod) {
      return;
    }
    _period = selectedPeriod;
    createChart();
    notifyListeners();
  }

  bool isPeriodPickerSelected(Periods selectedPeriod) =>
      _period == selectedPeriod;
  bool shouldDisplayChart() {
    print('charts_model | shouldDisplayChart | ${_filteredWeights.isNotEmpty}');
    return _filteredWeights.isNotEmpty;
  }
}
