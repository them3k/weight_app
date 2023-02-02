import 'package:weight_app/model/hive/models/weight.dart';
import 'package:weight_app/model/weight_model.dart';

Weight convertHiveToWeight(HiveWeight hive) {
  return Weight(value: hive.value, dateEntry: hive.dateEntry);
}

HiveWeight convertWeightToHive(Weight weight){
  return HiveWeight(value: weight.value, dateEntry: weight.dateEntry);
}