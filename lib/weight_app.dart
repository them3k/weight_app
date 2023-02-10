import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/chart_viewmodel.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/history_page.dart';
import 'package:weight_app/ui/views/main_page.dart';

class WeightApp extends StatefulWidget {
  WeightApp({Key? key}) : super(key: key);

  @override
  State<WeightApp> createState() => _WeightAppState();
}

class _WeightAppState extends State<WeightApp> {
  final WeightViewModel _weightViewModel = serviceLocator<WeightViewModel>();
  final ChartViewModel _chartViewModel = serviceLocator<ChartViewModel>();
  late ThemeData _themeData = _buildThemeData();

  @override
  void initState() {
    _themeData = _buildThemeData();
    print('Weight_app | _chartViewModel: ${_chartViewModel.hashCode}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _weightViewModel..loadData(),
          ),
          ChangeNotifierProvider(
              create: (context) => _chartViewModel..loadData())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _themeData,
            title: 'Weight App',
            home: MainPage()));
  }

  ThemeData _buildThemeData() {
    ThemeData base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    );
  }
}
