import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/history/history_view.dart';
import 'package:weight_app/ui/views/main_page.dart';
import 'package:weight_app/ui/views/splash_view.dart';

import 'model/weight_model.dart';

class WeightApp extends StatefulWidget {
  WeightApp({Key? key}) : super(key: key);

  @override
  State<WeightApp> createState() => _WeightAppState();
}

class _WeightAppState extends State<WeightApp> {
  late ThemeData _themeData = _buildThemeData();

  @override
  void initState() {
    _themeData = _buildThemeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<WeightModel>(
          lazy: false,
          create: (context) => WeightModel()..loadData(),
        builder: (context, child){
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: _themeData,
                title: 'Weight App',
                home: context.watch<WeightModel>().isInitialized
                ? MainPage()
                : SplashView());
        }
      ),
            ],
    );
  }

  ThemeData _buildThemeData() {
    ThemeData base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    );
  }
}
