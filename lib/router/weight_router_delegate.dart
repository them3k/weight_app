import 'package:flutter/cupertino.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/business_logic/view_model/weight_manager.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/edit/edit_view.dart';
import 'package:weight_app/ui/views/history/history_view.dart';
import 'package:weight_app/ui/views/home/home_view.dart';
import 'package:weight_app/ui/views/main_page.dart';
import 'package:weight_app/ui/views/onBoarding/on_boarding_view.dart';
import 'package:weight_app/ui/views/settings_view.dart';
import 'package:weight_app/ui/views/splash_view.dart';

import '../business_logic/utils/pages.dart';

class WeightRouterDelegate extends RouterDelegate<AppStateManagement>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AppStateManagement _appStateManagement =
      serviceLocator<AppStateManagement>();

  final WeightManager _weightManager = serviceLocator<WeightManager>();

  WeightRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    _appStateManagement.addListener(notifyListeners);
    _weightManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _handlePopPages,
      key: navigatorKey,
      pages: [
        if (!_appStateManagement.isInitialize) SplashView.page(),
        if (!_appStateManagement.onBoardingComplete &&
            _appStateManagement.isInitialize)
          OnBoardingView.page(),
        if (_appStateManagement.onBoardingComplete &&
            _appStateManagement.isInitialize)
          HomeView.page(),
        if (_appStateManagement.onBoardingComplete &&
            _appStateManagement.onHistory)
          HistoryView.page(),
        if (_appStateManagement.onBoardingComplete &&
            _appStateManagement.onSetting)
          SettingsView.page(),
        if (_appStateManagement.onBoardingComplete &&
            //_appStateManagement.onHistory &&
            _weightManager.index != -1)
          EditView.page(
            _weightManager.index,
            _weightManager.weight,
          )
      ],
    );
  }

  bool _handlePopPages(Route<dynamic> route, result){
    if(!route.didPop(result)){
      return false;
    }

    if(route.settings.name == Pages.settingsPath){
      _appStateManagement.onSettingTapped(false);
    }

    if(route.settings.name == Pages.historyPath){
      _appStateManagement.onHistoryTapped(false);
    }

    if(route.settings.name == Pages.editPath){
      _weightManager.onChangeSelectedWeightItem(-1);
    }


    return true;
  }

  @override
  late GlobalKey<NavigatorState> navigatorKey;

  @override
  void removeListener(VoidCallback listener) {
    _appStateManagement.removeListener(notifyListeners);
    _weightManager.removeListener(notifyListeners);
    super.removeListener(listener);
  }

  @override
  Future<void> setNewRoutePath(AppStateManagement configuration) async => null;
}
