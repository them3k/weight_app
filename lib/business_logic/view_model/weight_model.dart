import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';

class WeightModel extends BaseModel {

  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];

  List<Weight> get weight => _weights;

  void loadData() async {
    setBusy(true);
    _weights = await _storageService.getWeightData();
    setBusy(false);
  }

  Weight? getItemAtIndex(int index) {
    if (index == -1) {
      return null;
    }
    return _weights[index];
  }

  void _addWeight(Weight weight) async {
    setBusy(true);
    _weights.add(weight);
    await _storageService.addWeight(weight);
    setBusy(false);
  }

  void _updateWeight(Weight weight, int index) {
    setBusy(true);
    _weights[index] = weight;
    _storageService.updateWeight(weight, index);
    setBusy(false);
  }

  void deleteWeights(List<int> indexes) {
    setBusy(true);
    for (var element in indexes) {_weights.removeAt(element);}
    _storageService.deleteWeight(indexes);
    setBusy(false);

  }

  void saveWeight(double value, DateTime dateTime, int? index) {
    print('weight_model | saveWeight | value: $value dateTime: $dateTime index: $index');
    DateTime dateEntry = DateTime(dateTime.year,dateTime.month,dateTime.day);
    if(index == null){
      _addWeight(Weight(value: value, dateEntry: dateEntry));
    }else {
      _updateWeight(Weight(value: value, dateEntry: dateEntry), index);
    }
  }

}


