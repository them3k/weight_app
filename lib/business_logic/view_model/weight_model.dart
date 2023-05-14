import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';

class WeightModel extends BaseModel {
  final StorageService _storageService = serviceLocator<StorageService>();

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

  void _addWeight(Weight weight) {
    _weights.add(weight);
    print('weight_model | addWeight | ${weights.hashCode}');
    _storageService.addWeight(weight);
    print('weight_model | addWeight() | size: ${_weights.length} notify');
    notifyListeners();
  }

  void _updateWeight(Weight weight, int index) {
    _weights[index] = weight;
    _storageService.updateWeight(weight, index);
    print('weight_model | updateWeght() | notify');
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
    print(
        'weight_model | saveWeight | value: $value dateTime: $dateTime index: $index');
    DateTime dateEntry = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (index == null) {
      _addWeight(Weight(value: value, dateEntry: dateEntry));
    } else {
      _updateWeight(Weight(value: value, dateEntry: dateEntry), index);
    }
  }

  void saveInitWeight(double value) {
    DateTime now = DateTime.now();
    Weight weight = Weight(
        value: value.truncateToDouble(),
        dateEntry: DateTime(
            now.year,now.month,
            now.day));
    _addWeight(weight);
  }

  static List<Weight> sortByDate(List<Weight> list) {
    list.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));
    return list;
  }
}
