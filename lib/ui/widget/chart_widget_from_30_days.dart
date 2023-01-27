import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/model/weight_chart.dart';
import '../../model/weight.dart';

class WidgetChatWidgetFrom30days extends WeightChartWidget {
  final List<Weight> weights;

  const WidgetChatWidgetFrom30days(this.weights,{super.key});


  @override
  Widget build(BuildContext context) {
    return LineChart(
        showLineChartData(weights));
  }

}
