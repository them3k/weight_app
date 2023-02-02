import 'package:hive/hive.dart';
import 'package:weight_app/model/hive/models/weight.dart';

void registerAdapters() {
  Hive.registerAdapter(HiveWeightAdapter());
}