import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class SettingsViewModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  double _goal = 0.0;

  double get goal => _goal;

  void loadData() async {
    setBusy(true);
    _goal = await _storageService.getGoal();
    setBusy(false);
  }

  void updateGoal(double value) {
    _storageService.saveGoal(value);
  }
}