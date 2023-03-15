import 'package:weight_app/business_logic/view_model/base_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

import '../../model/weight_model.dart';
import '../../model/weight_presentation_model.dart';

class HistoryViewModel extends BaseModel {
  final StorageService _storageService = serviceLocator<StorageService>();

  List<Weight> _weights = [];

  List<Weight> get weights => _weights;

  List<int> _selectedIndexes = [];

  List<int> get selectedIndexes => _selectedIndexes;

  bool isItemsSelected = false;



  void loadData() async {
    setBusy(true);
    _weights = await _storageService.getWeightsByDate();
    print('history_view_model | loadData | ${weights.length}');
    setBusy(false);
  }

  void updateData(List<Weight> weights) async {
    setBusy(true);
    _weights = weights;
    setBusy(false);
  }

  Weight? getItemAtIndex(int index) {
    if (index == -1) {
      return null;
    }
    return _weights[index];
  }

  bool checkIfIsSelected(int index) => _selectedIndexes.contains(index);

  bool isWeightGrater(int index, int prevIndex) {
    if (index == 0) {
      return false;
    }
    return _weights[index].value > _weights[prevIndex].value;
  }

  void onTapDeleteSelectedItems() {
    clearSelectedIndexes();
    shouldShowDeleteIcon();
  }

  void clearSelectedIndexes() {
    _selectedIndexes = [];
  }

  void shouldShowDeleteIcon() {
    setBusy(true);
    isItemsSelected = _selectedIndexes.isNotEmpty;
    setBusy(false);
  }

  void selectItem(int index) {
    _selectedIndexes.add(index);
    shouldShowDeleteIcon();
  }

  void removeSelectedIndex(int index) {
    _selectedIndexes.remove(index);
    shouldShowDeleteIcon();
  }
}
