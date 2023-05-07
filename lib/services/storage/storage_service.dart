import 'package:hive/hive.dart';
import 'package:weight_app/model/weight_model.dart';

import '../../model/hive/models/weight.dart';

abstract class StorageService {

 Future<List<Weight>> getWeightData();

 Future<void> addWeight(Weight item);

 void deleteWeight(List<int> indexes);

 void updateWeight(Weight item, int index);

 Future<List<Weight>> getWeightsByDate();

 Future<List<Weight>> loadWeightFromDaysAgo(int days);

 Future<double> getMinWeightValue();

 Future<double> getLastWeightValue();

 Future<double> getGoal();

 void saveGoal(double goal);

 bool isOnBoardingCompleted();

 void onBoardingComplete();

 void saveDarkModeState(bool isEnabled);

 bool fetchDarkModeState();
}