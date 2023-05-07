import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../model/chart.dart';
import '../../model/weight_model.dart';

abstract class ChartService {

  Future<Chart> fetchDataChart(List<Weight> weights, DateTime now);

  List<FlSpot> createSpots(List<Weight> weights);

  double countDiff();

  double getMinWeightValue();

  double getMaxWeightValue();

  double countRightTitleInterval();

  double countBottomTitleInterval();

  double countMaxY();

  double countMinY();

  bool isDivisible(double dividend, double divider);

  double countMinX();

  double countMaxX();
}