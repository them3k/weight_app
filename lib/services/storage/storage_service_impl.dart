import 'dart:math';
import 'package:hive/hive.dart';
import 'package:weight_app/business_logic/utils/constants.dart';
import 'package:weight_app/model/hive/convertors.dart';
import 'package:weight_app/services/storage/storage_service.dart';

import '../../model/hive/models/weight.dart';
import '../../model/weight_model.dart';

class StorageServiceImpl extends StorageService {

  Box<HiveWeight> getBox() {
    return Hive.box<HiveWeight>(Constants.WEIGHT_BOX);
  }

  Box<double> getGoalBox() {
    return Hive.box<double>(Constants.GOAL_BOX);
  }

  Box<bool> getAppStateManagementBox() {
    return Hive.box<bool>(Constants.APP_STATE_MANAGEMENT_BOX);
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
      print('storage_services_impl | deleteWeight | indexes: $indexes');
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
    if(weights.isEmpty){
      return 0.0;
    }
    return weights.map((e) => e.value).reduce(min);
  }

  @override
  Future<double> getLastWeightValue() async {
    var weights = await getWeightsByDate();
    if(weights.isEmpty){
      return 0.0;
    }
    return weights.last.value;
  }

  @override
  Future<double> getGoal() async {
    Box<double> box = getGoalBox();
    return box.get(Constants.GOAL_KEY) ?? 0;
  }

  @override
  void saveGoal(double goal) {
    getGoalBox().put(Constants.GOAL_KEY, goal);
  }

  @override
  bool isOnBoardingCompleted() {
    Box<bool> box = getAppStateManagementBox();
    return box.get(Constants.ON_BOARDING_COMPLETED_KEY) ?? false;
  }

  @override
  void onBoardingComplete() {
    getAppStateManagementBox().put(Constants.ON_BOARDING_COMPLETED_KEY, true);
  }

  @override
  bool fetchDarkModeState() {
    return getAppStateManagementBox().get(Constants.DARK_MODE_KEY) ?? false;
  }

  @override
  void saveDarkModeState(bool isEnabled) {
    Box<bool> box = getAppStateManagementBox();
    box.put(Constants.DARK_MODE_KEY, isEnabled);
  }
}