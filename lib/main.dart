import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weight_app/model/hive/register_adapters.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/weight_app.dart';
import 'business_logic/utils/constants.dart';
import 'model/hive/models/weight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  setupServiceLocator();
  await serviceLocator.allReady();
  runApp(WeightApp());
}

Future? initializeHive() async {
  await Hive.initFlutter();
  registerAdapters();
  await Hive.openBox<HiveWeight>(Constants.WEIGHT_BOX);
  await Hive.openBox<double>(Constants.GOAL_BOX);
  await Hive.openBox<bool>(Constants.APP_STATE_MANAGEMENT_BOX);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

}
