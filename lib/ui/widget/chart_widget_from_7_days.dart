import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:weight_app/model/weight.dart';
import 'package:weight_app/model/weight_chart.dart';

class WeightChartWidgetFrom7days extends WeightChartWidget {

  final List<Weight> weights;

  const WeightChartWidgetFrom7days(this.weights, {super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(showLineChartData(weights));
  }

}