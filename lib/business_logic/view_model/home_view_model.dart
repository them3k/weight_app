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

  void loadData() async {
    print('HomeViewModel | loadData');
    setBusy(true);
    await fetchLastWeight();
    await fetchGainedWeightFromLastWeek();
    setBusy(false);
  }

  Future fetchLastWeight() async {
    _lastWeight = await _storageService.getLastWeightValue();
    print('HomeViewModel | fetchLastWeight : $_lastWeight');
  }

  Future<double> _getLastWeightValue() async =>
      _storageService.getLastWeightValue();

  Future fetchGainedWeightFromLastWeek() async {
    _gainedWeightFromLastWeek = await _countGainWeightFromLastWeek();
  }

  Future<double> _countGainWeightFromLastWeek() async {
    List<Weight> lastWeekWeights =
        await _storageService.loadWeightFromDaysAgo(Constants.WEEKLY);

    if(lastWeekWeights.isEmpty) {
      return 0.0;
    }
    double avg = lastWeekWeights.map((e) => e.value).reduce((a, b) => a + b) /
        lastWeekWeights.length;

    return await _getLastWeightValue() - avg;
  }

}
