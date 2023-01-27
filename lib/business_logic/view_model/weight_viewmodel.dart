import 'package:flutter/widgets.dart';
import 'package:weight_app/business_logic/utils/utils.date_format.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

import '../../model/weight.dart';

class WeightViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];
  List<WeightPresentation> get weights {
    return _preparePresentation(_weights);
  }

  void loadData() async {
    _weights = await _storageService.getWeightData();
    notifyListeners();
    print('ViewModel: $hashCode');
  }

  Weight? getItemAtIndex(int index){
    if(index == -1){
      return null;
    }
    return _weights[index];
  }

  void addWeight(Weight weight) async {
    print('ViewModel: $hashCode');
    await _storageService.addWeight(weight);
    loadData();
  }

  void updateWeight(Weight weight, int index) {
    print('ViewModel | updateWeight: $weight | index: $index');
    _storageService.updateWeight(weight, index);
    loadData();
  }

  void deleteWeight(List<int> indexes) {
    _storageService.deleteWeight(indexes);
    loadData();
  }

  bool isWeightGrater(int index, int prevIndex){
    if(index == 0){
      return false;
    }
    return _weights[index].value > _weights[prevIndex].value;
  }

  List<WeightPresentation> _preparePresentation(List<Weight> list) {
    List<WeightPresentation> weightPresentationList = [];

    list.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));

    for (Weight weight in list) {
      weightPresentationList.add(WeightPresentation(
          weight.value.toString(), DateFormat.displayDate(weight.dateEntry)));
    }
    return weightPresentationList;
  }

  double parseWeight(String value) {
    if (value.isEmpty) {
      return -1;
    }
    return double.parse(value.replaceAll(',', '.'));
  }
}

class WeightPresentation {
  final String value;
  final String dateEntry;

  WeightPresentation(this.value, this.dateEntry);
}
