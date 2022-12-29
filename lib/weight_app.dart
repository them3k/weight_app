import 'package:flutter/material.dart';
import 'package:weight_app/page/home_page.dart';
import 'package:weight_app/repository/repository.dart';
import 'package:weight_app/repository/weight_repository.dart';

class WeightApp extends StatelessWidget {
  const WeightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repository repo = WeightRepository();

    return MaterialApp(
      title: 'Weight App',
      home: HomePage(repository: repo,),
    );
  }
}
