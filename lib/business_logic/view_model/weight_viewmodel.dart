import 'package:flutter/widgets.dart';
import 'package:weight_app/business_logic/utils/utils.date_format.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import '../../model/weight_model.dart';
import '../utils/constants.dart';

class WeightViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];
  List<int> _selectedIndexes = [];
  late bool isItemsSelected = false;
  double _goal = 0;
  double _gainWeightFromLastWeek = 0;
  double _lastWeight = 0;

  double get goal => _goal;

  double get gainWeightFromLastWeek => _gainWeightFromLastWeek;

  double get lastWeight => _lastWeight;

  void updateGoal(double value) {
    if (value == _goal) {
      return;
    }
    _goal = value;
    notifyListeners();
    saveGoal(goal);
  }

  Future<double> getGoalValue() => _storageService.getGoal();

  void saveGoal(double goal) =>
      _storageService.saveGoal(goal);



  List<WeightPresentation> get weights {
    return WeightPresentation.preparePresentation(_weights);
  }

  void loadData() async {
    _weights = await _storageService.getWeightData();
    _lastWeight = await getLastWeightValue();
    _gainWeightFromLastWeek = await countGainWeightFromLastWeek();
    _goal = await getGoalValue();
    notifyListeners();
    print('ViewModel: $hashCode');
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

class WeightPresentation {
  final String value;
  final String dateEntry;

  WeightPresentation(this.value, this.dateEntry);

  static List<WeightPresentation> preparePresentation(List<Weight> list) {
    List<WeightPresentation> weightPresentationList = [];

    list.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));

    for (Weight weight in list) {
      weightPresentationList.add(WeightPresentation(
          weight.value.toString(), DateFormat.displayDate(weight.dateEntry)));
    }
    return weightPresentationList;
  }

  static double parseWeight(String value) {
    if (value.isEmpty) {
      return -1;
    }
    return double.parse(value.replaceAll(',', '.'));
  }
}
