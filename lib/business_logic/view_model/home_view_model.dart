import 'package:weight_app/business_logic/helpers/weight_filters.dart';
import 'package:weight_app/business_logic/view_model/base_model.dart';

import '../../model/weight_model.dart';
import '../../service_locator.dart';
import '../../services/storage/storage_service.dart';

class HomeViewModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  double _lastWeight = 0.0;

  double get lastWeight => _lastWeight;

  double _gainedWeightFromLastWeek = 0.0;

  double get gainedWeightFromLastWeek => _gainedWeightFromLastWeek;

  void loadData(List<Weight> weights) async {
    print('HomeViewModel | loadData');
    setBusy(true);
    loadLastWeight(weights);
    loadGainedWeightFromLastWeek(WeightFilters.filterWeeklyWeights(weights),lastWeight);
    setBusy(false);
  }

  void loadLastWeight(List<Weight> weights) async {
    if(weights.isEmpty){
      return Future.delayed(Duration.zero);
    }
    _lastWeight = weights.last.value;
    print('HomeViewModel | fetchLastWeight : $_lastWeight');
  }

  void loadGainedWeightFromLastWeek(List<Weight> weights, double lastWeight) async {
    if(weights.isEmpty){
      return Future.delayed(Duration.zero);
    }
    _gainedWeightFromLastWeek = _countGainWeightFromLastWeek(weights,lastWeight);
  }

  double _countGainWeightFromLastWeek(List<Weight> lastWeekWeights, double lastWeight) {

    if(lastWeekWeights.isEmpty) {
      return 0.0;
    }

    double avg = lastWeekWeights.map((e) => e.value).reduce((a, b) => a + b) /
        lastWeekWeights.length;

    return lastWeight - avg;
  }

}
