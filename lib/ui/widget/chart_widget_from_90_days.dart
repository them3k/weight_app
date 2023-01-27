import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/model/weight_chart.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import '../../model/weight.dart';

class WeightChartWidgetFrom90days extends WeightChartWidget {

  final List<Weight> _weights;


  const WeightChartWidgetFrom90days(this._weights, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return LineChart(showLineChartData(_weights));
  }

  // @override
  // List<FlSpot> convertToDaysFlSpot(List<Weight> weights) {
  //   List<FlSpot> spots = [];
  //   for (int i = 0; i < weights.length; i++) {
  //     if(i%3==0){
  //       spots.add(FlSpot(i.toDouble(), weights[i].value));
  //     }
  //   }
  //   return spots;
  // }


}