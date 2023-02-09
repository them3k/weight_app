import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';

import '../../model/hive/models/weight.dart';
import '../../model/weight_model.dart';

class WeightChartWidgetFrom180days extends WeightChartWidget {

  final List<Weight> weights;

  WeightChartWidgetFrom180days(this.weights, {super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(showLineChartData(weights,context));
  }


}