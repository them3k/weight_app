import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';

import '../../model/weight_model.dart';

class WeightChartWidgetFrom7days extends WeightChartWidget {
  final List<Weight> weights;

  WeightChartWidgetFrom7days(this.weights, {super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(showLineChartData(weights, context));
  }
}
