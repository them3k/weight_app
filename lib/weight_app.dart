import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/app_state_manager.dart';
import 'package:weight_app/business_logic/view_model/weight_manager.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/router/weight_router_delegate.dart';
import 'package:weight_app/service_locator.dart';

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
            theme: Provider.of<AppStateManagement>(context).isDarkModeEnabled
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
        ChangeNotifierProvider<WeightManager>(
            create: (_) => serviceLocator<WeightManager>()),
        ChangeNotifierProvider<WeightModel>(
            lazy: false,
            create: (context) => WeightModel()..loadData()),
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
