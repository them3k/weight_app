import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';

class WeightModel extends BaseModel {
  final StorageService _storageService = serviceLocator<StorageService>();

  StorageService get storageService => _storageService;

  List<Weight> _weights = [];

  List<Weight> get weights => _weights;


  Future<bool> loadData() async {
    _weights = await _storageService.getWeightsByDate();
    print('weight_model | loadData() | notify');
    notifyListeners();
    return true;
  }

  Weight? getItemAtIndex(int index) {
    if (index == -1) {
      return null;
    }
    return _weights[index];
  }

  void addWeight(Weight weight) {
    _weights.add(weight);
    _storageService.addWeight(weight);
    notifyListeners();
  }

  void updateWeight(Weight weight, int index) {
    _weights[index] = weight;
    _storageService.updateWeight(weight, index);
    notifyListeners();
  }

  void deleteWeights(List<int> indexes) {
    for (var element in indexes) {
      _weights.removeAt(element);
    }
    _storageService.deleteWeight(indexes);
    print('weight_model | deleteWeights() | notify');
    notifyListeners();
  }

  void saveWeight(double value, DateTime dateTime, int? index) {
  
    DateTime dateEntry = simplifyDateTimeFormat(dateTime);
    if (index == null) {
      addWeight(Weight(value: value, dateEntry: dateEntry));
    } else {
      updateWeight(Weight(value: value, dateEntry: dateEntry), index);
    }
  }

  void saveInitWeight(double value) {
    DateTime now = DateTime.now();
    Weight weight = Weight(
        value: value.truncateToDouble(),
        dateEntry: DateTime(
            now.year,now.month,
            now.day));
    addWeight(weight);
  }

  DateTime simplifyDateTimeFormat(DateTime dateTime) =>
    DateTime(dateTime.year,dateTime.month,dateTime.day);

  static List<Weight> sortByDate(List<Weight> list) {
    list.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));
    return list;
  }
}
