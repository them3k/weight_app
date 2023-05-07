import 'package:flutter/cupertino.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class OnBoardingViewModel extends ChangeNotifier {

  final StorageService _storageService = serviceLocator<StorageService>();

  void saveGoal(double value){
    _storageService.saveGoal(value.truncateToDouble());
  }
  
}