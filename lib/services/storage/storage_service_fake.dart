import 'dart:math';

import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class StorageServiceFake implements StorageService {

  double goal = 0;

  List<Weight> fakeList = List.generate(
      180,
      (index) => Weight(
          value: (index / 10) +  60 + Random().nextInt(20) + 16,
          dateEntry: DateTime.now().subtract(Duration(days: index))));

  @override
  Future<List<Weight>> getWeightData() async => fakeList;

  @override
  Future<void> addWeight(Weight item) async {
    fakeList.add(item);
  }

  @override
  void deleteWeight(List<int> indexes) {
    for (int index in indexes) {
      fakeList.removeAt(index);
    }
  }

  @override
  void updateWeight(Weight item, int index) {
    fakeList[index] = item;
  }

  @override
  Future<List<Weight>> getWeightsByDate() async {
    fakeList.sort((a, b) =>a.dateEntry.compareTo(b.dateEntry));
    return fakeList;
  }

  @override
  Future<List<Weight>> loadWeightFromDaysAgo(int days) async {
    var weights = await getWeightsByDate();

    DateTime diffDays = DateTime.now().subtract(Duration(days: days));

    return weights
        .where((element) =>
            element.dateEntry.millisecondsSinceEpoch >
            diffDays.millisecondsSinceEpoch)
        .toList();
  }

  @override
  Future<double> getMinWeightValue() async =>
      fakeList.map((e) => e.value).reduce(min);


  Future<List<Weight>> weeklyFakeList(int length) async {
    return List.generate(
        length,
            (index) => Weight(
            value: (index / 10) +  60 + Random().nextInt(2) - 1,
            dateEntry: DateTime.now().subtract(Duration(days: index))));
  }

  @override
  Future<double> getLastWeightValue() async =>
      fakeList.last.value;

  @override
  Future<double> getGoal() async {
    return goal;
  }

  @override
  void saveGoal(double goal) {
    if(goal != this.goal) {
      return;
    }
    this.goal = goal;
  }
}
