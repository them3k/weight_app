import 'package:flutter/cupertino.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/services/storage/storage_service.dart';

class AppStateManagement extends ChangeNotifier {

  final StorageService _storageService = serviceLocator<StorageService>();

  int _index = 0;
  bool _isInitialize = false;
  bool _onBoardingComplete = false;
  bool _onSetting = false;
  bool _onHistory = false;
  bool _onHome = false;
  bool _isDarkModeEnabled = false;

  int get index => _index;
  bool get isInitialize => _isInitialize;
  bool get onBoardingComplete => _onBoardingComplete;
  bool get onSetting => _onSetting;
  bool get onHistory => _onHistory;
  bool get onHome => _onHome;
  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void loadValues() {
    print('app_state_manager | loadValues');
    fetchDarkModeState();
    fetchOnBoardingCompleted();
  }

  void initializeApp() async {
    print('appStateManagement | initializeApp | ');
    _isInitialize = true;
    notifyListeners();
  }

  void onBoardingCompleteTapped(bool value){
    _onBoardingComplete = value;
    if(_onBoardingComplete){
      saveOnBoardingStateResult();
    }
    notifyListeners();
  }

  void onSettingTapped(bool value){
    _index = 2;
    _onSetting = value;
    _onHome = false;
    notifyListeners();
  }

  void onHistoryTapped(bool value){
    _index = 1;
    _onHistory = value;
    _onHome = false;
    _onSetting = false;
    notifyListeners();
  }

  void onHomeTapped(bool value){
    _index = 0;
    _onHome = value;
    _onHistory = false;
    _onSetting = false;
    notifyListeners();
  }

  void saveOnBoardingStateResult() {
    _storageService.onBoardingComplete();
  }

  void fetchOnBoardingCompleted() {
    print('appStateManager | fetchOnBoardingCompleted');
    bool result = _storageService.isOnBoardingCompleted();
    _onBoardingComplete = result;
    initializeApp();
  }

  void toggleDarkMode() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    saveDarkModeState();
    notifyListeners();
  }

  void saveDarkModeState() {
    _storageService.saveDarkModeState(_isDarkModeEnabled);
  }

  void fetchDarkModeState() {
    _isDarkModeEnabled = _storageService.fetchDarkModeState();
    notifyListeners();
  }

}