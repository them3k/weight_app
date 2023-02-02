import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';

import '../../model/hive/models/weight.dart';
import '../../model/weight_model.dart';

class WeightChartWidgetFrom90days extends WeightChartWidget {

  final List<Weight> weights;


  const WeightChartWidgetFrom90days(this.weights, {super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(showLineChartData(weights));
  }

  @override
  List<FlSpot> convertToDaysFlSpot(List<Weight> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      if(i%9==0){
        spots.add(FlSpot(i.toDouble(), weights[i].value));
      }
    }
    return spots;
  }

}