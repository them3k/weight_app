import 'package:weight_app/business_logic/view_model/base_model.dart';

import '../../model/weight_model.dart';
import '../../service_locator.dart';
import '../../services/storage/storage_service.dart';
import '../utils/constants.dart';

class HomeViewModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  double _gainedWeightFromLastWeek = 0.0;

  double get gainedWeightFromLastWeek => _gainedWeightFromLastWeek;

  void loadData() {
    setBusy(true);
    fetchGainedWeightFromLastWeek();
    setBusy(false);
  }

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
