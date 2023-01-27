import 'package:hive/hive.dart';
import 'package:weight_app/business_logic/utils/constants.dart';
import 'package:weight_app/services/storage/storage_service.dart';

import '../../model/weight.dart';

class StorageServiceImpl extends StorageService {

  Box<Weight> getBox() {
    return Hive.box<Weight>(Constants.NAME_BOX);
  }

  @override
  Future<void> addWeight(Weight item) async {
    Hive.box<Weight>(Constants.NAME_BOX).add(item);
  }

  @override
  Future<List<Weight>> getWeightData() async {
    final box = getBox();
    return box.values.toList().cast<Weight>();
  }

  @override
  void deleteWeight(List<int> indexes) {
    final box = getBox();
    for (var index in indexes) {
      box.deleteAt(index);
    }
  }

  @override
  void updateWeight(Weight item, int index) {
    getBox().putAt(index, item);
  }

  @override
  Future<List<Weight>> getWeightsByDate() async {
    var list = await getWeightData();
    list.sort((a,b) => a.dateEntry.compareTo(b.dateEntry));
    return list;
  }

  @override
  Future<List<Weight>> loadWeightFromDaysAgo(int days) async {
    var weights = await getWeightsByDate();

    DateTime diffDays = DateTime.now().subtract(Duration(days: days));

    return weights.where((element) => element.dateEntry.millisecondsSinceEpoch > diffDays.millisecondsSinceEpoch).toList();

  }


}