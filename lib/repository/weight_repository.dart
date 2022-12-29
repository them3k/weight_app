import 'package:weight_app/model/weight.dart';
import 'package:weight_app/repository/repository.dart';

class WeightRepository extends Repository<Weight> {

  List<Weight> weights = [];

  @override
  List<Weight> fetchFakeData() {
    List<Weight> fakeList = [
      Weight(value: 75.0, dateEntry: DateTime.now().add(const Duration(days: 1))),
      Weight(value: 63.2, dateEntry: DateTime.now().add(const Duration(days: 2))),
      Weight(value: 68.2, dateEntry: DateTime.now().add(const Duration(days: 3))),
      Weight(value: 74.0, dateEntry: DateTime.now().add(const Duration(days: 4))),
      Weight(value: 72.7, dateEntry: DateTime.now().add(const Duration(days: 5))),
      Weight(value: 78.3, dateEntry: DateTime.now().add(const Duration(days: 6))),
      Weight(value: 79.4, dateEntry: DateTime.now().add(const Duration(days: 7))),
      Weight(value: 80.5, dateEntry: DateTime.now().add(const Duration(days: 8))),
      Weight(value: 82.3, dateEntry: DateTime.now().add(const Duration(days: 9))),
      Weight(value: 84.5, dateEntry: DateTime.now().add(const Duration(days: 10))),
    ];

    return fakeList;
  }

  @override
  void addWeight(Weight item) {git 
    weights.add(item);
    print('Weight Repo | addWeight | Weight: $item');
  }

  @override
  List<Weight> fetchData() {
    return weights;
  }
}