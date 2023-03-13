
import 'package:get_it/get_it.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import 'package:weight_app/services/storage/storage_service_fake.dart';
import 'package:weight_app/services/storage/storage_service_impl.dart';

import 'business_logic/view_model/charts_model.dart';



GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  // serviceLocator.registerFactory<WeightViewModel>(() => WeightViewModel());
  // serviceLocator.registerFactory<ChartViewModel>(() => ChartViewModel());
  serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());

}