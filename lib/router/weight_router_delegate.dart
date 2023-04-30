import 'package:flutter/cupertino.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/home/home_view.dart';
import 'package:weight_app/ui/views/main_page.dart';
import 'package:weight_app/ui/views/splash_view.dart';

class WeightRouterDelegate extends RouterDelegate<AppStateManagement>
with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final AppStateManagement appStateManagement = serviceLocator<AppStateManagement>();


  WeightRouterDelegate(): navigatorKey = GlobalKey<NavigatorState>() {
    appStateManagement.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route,result) => route.didPop(result),
      key: navigatorKey,
      pages: [
        if(!appStateManagement.isInitialize) SplashView.page(),
        if(appStateManagement.isInitialize) HomeView.page()],
    );
  }

  @override
  late GlobalKey<NavigatorState> navigatorKey;


  @override
  void removeListener(VoidCallback listener) {
    appStateManagement.removeListener(notifyListeners);
    super.removeListener(listener);
  }

  @override
  Future<void> setNewRoutePath(AppStateManagement configuration) async =>
      null;

}