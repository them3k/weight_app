import 'package:weight_app/business_logic/view_model/base_model.dart';

import '../../model/weight_model.dart';
import '../../service_locator.dart';
import '../../services/storage/storage_service.dart';
import '../utils/constants.dart';

class HomeViewModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  double _lastWeight = 0.0;

  double get lastWeight => _lastWeight;

  double _gainedWeightFromLastWeek = 0.0;

  double get gainedWeightFromLastWeek => _gainedWeightFromLastWeek;

  void loadData() {
    setBusy(true);
    fetchLastWeight();
    fetchGainedWeightFromLastWeek();
    setBusy(false);
  }

  Future fetchLastWeight() async {
    _lastWeight = await _storageService.getLastWeightValue();
  }

  Future<double> _getLastWeightValue() async =>
      _storageService.getLastWeightValue();

  Future fetchGainedWeightFromLastWeek() async {
    _gainedWeightFromLastWeek = await _countGainWeightFromLastWeek();
  }

  Future<double> _countGainWeightFromLastWeek() async {
    List<Weight> lastWeekWeights =
        await _storageService.loadWeightFromDaysAgo(Constants.WEEKLY);
    double avg = lastWeekWeights.map((e) => e.value).reduce((a, b) => a + b) /
        lastWeekWeights.length;

    return await _getLastWeightValue() - avg;
  }
}
