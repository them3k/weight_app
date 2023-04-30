import 'package:flutter/cupertino.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class AppStateManagement extends ChangeNotifier {

  final StorageService _storageService = serviceLocator<StorageService>();

  bool _isInitialize = false;
  bool _onBoardingComplete = false;
  bool _onSetting = false;
  bool _onHistory = false;
  bool _onHome = false;


  bool get isInitialize => _isInitialize;
  bool get onBoardingComplete => _onBoardingComplete;
  bool get onSetting => _onSetting;
  bool get onHistory => _onHistory;
  bool get onHome => _onHome;

  void initializeApp() async {
    _isInitialize = true;
    print('appStateManagement | initializeApp | ');
    notifyListeners();
  }

  void onBoardingCompleteTapped(bool value){
    _onBoardingComplete = value;
    notifyListeners();
  }

  void onSettingTapped(bool value){
    _onSetting = value;
    notifyListeners();
  }

  void onHistoryTapped(bool value){
    _onHistory = value;
    notifyListeners();
  }

  void onHomeTapped(bool value){
    _onHome = value;
    notifyListeners();
  }


}