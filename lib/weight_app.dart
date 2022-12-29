import 'package:flutter/material.dart';
import 'package:weight_app/page/home_page.dart';

class WeightApp extends StatelessWidget {
  const WeightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weight App',
      home: HomePage(),
    );
  }
}
