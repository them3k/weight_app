import 'dart:math';

import 'package:hive/hive.dart';
import 'package:weight_app/business_logic/utils/constants.dart';
import 'package:weight_app/model/hive/convertors.dart';
import 'package:weight_app/services/storage/storage_service.dart';

import '../../model/hive/models/weight.dart';
import '../../model/weight_model.dart';

class StorageServiceImpl extends StorageService {

  Box<HiveWeight> getBox() {
    return Hive.box<HiveWeight>(Constants.NAME_BOX);
  }

  @override
  Future<Future<int>> addWeight(Weight item) async {
    HiveWeight hiveWeight = convertWeightToHive(item);
    return getBox().add(hiveWeight);
  }


  @override
  Future<List<Weight>> getWeightData() async {
    Box<HiveWeight> box = getBox();
    List<HiveWeight> list = box.values.toList();
    List<Weight> result = [];
    for(HiveWeight item in list){
      result.add(convertHiveToWeight(item));
    }
    return result;
  }


  @override
  void deleteWeight(List<int> indexes) {
    final Box<HiveWeight> box = getBox();
    for (var index in indexes) {
      box.deleteAt(index);
    }
  }

  @override
  void updateWeight(Weight item, int index) async {
    final Box<HiveWeight> box = getBox();
    HiveWeight hiveWeight = convertWeightToHive(item);
    box.putAt(index, hiveWeight);
  }


  @override
  Future<List<Weight>> getWeightsByDate() async {
    final List<Weight> list = await getWeightData();
    list.sort((a,b) => a.dateEntry.compareTo(b.dateEntry));
    return list;
  }

  @override
  Future<List<Weight>> loadWeightFromDaysAgo(int days) async {
    var weights = await getWeightsByDate();
    DateTime diffDays = DateTime.now().subtract(Duration(days: days));
    return weights.where((element) => element.dateEntry.millisecondsSinceEpoch > diffDays.millisecondsSinceEpoch).toList();

  }

  @override
  Future<double> getMinWeightValue() async {
    var weights = await getWeightData();
    return weights.map((e) => e.value).reduce(min);
  }


}