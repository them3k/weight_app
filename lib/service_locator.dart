
import 'package:get_it/get_it.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/business_logic/view_model/weight_manager.dart';
import 'package:weight_app/router/weight_router_delegate.dart';
import 'package:weight_app/services/chart_service/chart_service.dart';
import 'package:weight_app/services/chart_service/chart_service_impl.dart';
import 'package:weight_app/services/storage/storage_service.dart';
import 'package:weight_app/services/storage/storage_service_impl.dart';

import 'business_logic/view_model/charts_model.dart';



GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  // serviceLocator.registerFactory<WeightViewModel>(() => WeightViewModel());
  // serviceLocator.registerFactory<ChartViewModel>(() => ChartViewModel());
  serviceLocator.registerLazySingleton<AppStateManagement>(() => AppStateManagement());
  serviceLocator.registerLazySingleton<WeightManager>(() => WeightManager());
  serviceLocator.registerLazySingleton<WeightRouterDelegate>(() => WeightRouterDelegate());

  serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  serviceLocator.registerFactory<ChartService>(() => ChartServiceImpl());

}