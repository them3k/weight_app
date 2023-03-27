import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/business_logic/view_model/dark_mode_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/history/history_view.dart';
import 'package:weight_app/ui/views/main_page.dart';
import 'package:weight_app/ui/views/on_boarding_view.dart';
import 'package:weight_app/ui/views/splash_view.dart';

import 'model/weight_model.dart';

class WeightApp extends StatefulWidget {
  WeightApp({Key? key}) : super(key: key);

  @override
  State<WeightApp> createState() => _WeightAppState();
}

class _WeightAppState extends State<WeightApp> {
  late ThemeData _themeData;

  @override
  void initState() {
    _themeData = _buildLightThemeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeModel>(
            create: (context) => DarkModeModel()),
        ChangeNotifierProvider<WeightModel>(
          lazy: false,
          create: (context) => WeightModel()..loadData(),
        builder: (context, child){
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Provider.of<DarkModeModel>(context).isDark
                ? _buildDarkThemeData()
                : _buildLightThemeData(),
                title: 'Weight App',
                home: OnBoardingView()
            );
                // context.watch<WeightModel>().isInitialized
                // ? MainPage()
                // : SplashView());
        }
      ),
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
