import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/weight_app.dart';
import 'package:flutter/services.dart';

import 'business_logic/utils/constants.dart';
import 'model/weight.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(WeightAdapter());
  await Hive.openBox<Weight>(Constants.NAME_BOX);
  setupServiceLocator();
  await serviceLocator.allReady();
  runApp(WeightApp());
}
