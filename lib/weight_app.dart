import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/business_logic/view_model/dark_mode_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/router/weight_router_delegate.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/onBoarding/on_boarding_view.dart';

class WeightApp extends StatefulWidget {
  WeightApp({Key? key}) : super(key: key);

  @override
  State<WeightApp> createState() => _WeightAppState();
}

class _WeightAppState extends State<WeightApp> {
  bool isInitialize = false;

  final _weightsRouterDelegate = serviceLocator<WeightRouterDelegate>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<DarkModeModel>(context).isDark
                ? _buildDarkThemeData()
                : _buildLightThemeData(),
            title: 'Weight App',
            home: Router(
              routerDelegate: _weightsRouterDelegate,
            ));
      } ,
      providers: [
        ChangeNotifierProvider<AppStateManagement>(
            create: (_) => serviceLocator<AppStateManagement>()),
        ChangeNotifierProvider<DarkModeModel>(
            create: (context) => DarkModeModel()),
        ChangeNotifierProvider<WeightModel>(
            lazy: false,
            create: (context) => WeightModel()),
        ChangeNotifierProxyProvider<AppStateManagement, WeightModel>(
            create: (context) => WeightModel(),
            update: (_, appStateManagement, weightModel) {
              if(weightModel == null && appStateManagement.isInitialize){
                return WeightModel()..loadData();
              }else if(weightModel != null && appStateManagement.isInitialize) {
                return weightModel..loadData();
              }else if(weightModel !=null && !appStateManagement.isInitialize){
                return weightModel;
              }else {
                return WeightModel();
              }
            }),
      ],
    );
  }

  ThemeData _buildLightThemeData() {
    ThemeData base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    );
  }

  ThemeData _buildDarkThemeData() {
    ThemeData base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    );
  }
}
