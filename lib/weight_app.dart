import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/colors.dart';
import 'package:weight_app/service_locator.dart';
import 'package:weight_app/ui/views/history_page.dart';

class WeightApp extends StatefulWidget {
  WeightApp({Key? key}) : super(key: key);

  @override
  State<WeightApp> createState() => _WeightAppState();
}

class _WeightAppState extends State<WeightApp> {
  final WeightViewModel viewModel = serviceLocator<WeightViewModel>();
  late ThemeData _themeData = _buildThemeData();

  @override
  void initState() {
    _themeData = _buildThemeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel..loadData(),
        child: MaterialApp(
          theme: _themeData,
            title: 'Weight App', home: HomePage()));
  }

  ThemeData _buildThemeData() {
    ThemeData base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    );
  }

}
