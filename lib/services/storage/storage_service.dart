import '../../model/weight.dart';

abstract class StorageService {

 Future<List<Weight>> getWeightData();

 Future<void> addWeight(Weight item);

 void deleteWeight(List<int> indexes);

 void updateWeight(Weight item, int index);

 Future<List<Weight>> getWeightsByDate();

 Future<List<Weight>> loadWeightFromDaysAgo(int days);
}