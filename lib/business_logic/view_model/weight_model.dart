import 'package:flutter/widgets.dart';
import 'package:weight_app/business_logic/utils/utils.date_format.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';
import '../../model/weight_presentation_model.dart';
import '../utils/constants.dart';

class WeightModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];
  List<int> _selectedIndexes = [];
  late bool isItemsSelected = false;

  List<Weight> get weight => _weights;

  void loadData() async {
    _weights = await _storageService.getWeightData();
    print('weight_view_model | loadData()');
  }

  Weight? getItemAtIndex(int index) {
    if (index == -1) {
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

  void deleteWeights(List<int> indexes) {
    _storageService.deleteWeight(indexes);
    loadData();
  }

  bool isWeightGrater(int index, int prevIndex) {
    print('weight_viewModel | $index | $prevIndex');
    if (index == 0) {
      return false;
    }
    return _weights[index].value > _weights[prevIndex].value;
  }

  Future<double> getMinWeightValue() => _storageService.getMinWeightValue();

  Future<double> getLastWeightValue() => _storageService.getLastWeightValue();


  Future<double> countGainWeightFromLastWeek() async {
    List<Weight> lastWeekWeights =
        await _storageService.loadWeightFromDaysAgo(Constants.WEEKLY);
    double avg = lastWeekWeights.map((e) => e.value).reduce((a, b) => a + b) /
        lastWeekWeights.length;

    return await getLastWeightValue() - avg;
  }

  void onTapDeleteSelectedItems() {
    deleteWeights(_selectedIndexes);
    clearSelectedIndexes();
  }

  void clearSelectedIndexes() {
    _selectedIndexes = List.empty();
  }

  void shouldShowDeleteIcon() {
    isItemsSelected = _selectedIndexes.isNotEmpty;
    notifyListeners();
    print('WeightViewModel | shouldShowDeleteIcon | result: $isItemsSelected');
    print(
        'WeightViewModel | shouldShowDeleteIcon | selected: $_selectedIndexes');
  }

  bool checkIfIsSelected(int index) => _selectedIndexes.contains(index);

  void selectItem(int index) {
    _selectedIndexes.add(index);
    shouldShowDeleteIcon();
  }

  void removeSelectedIndex(int index) {
    _selectedIndexes.remove(index);
    shouldShowDeleteIcon();
  }
}


