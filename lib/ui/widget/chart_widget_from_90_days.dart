import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import '../../model/weight_model.dart';

class WeightChartWidgetFrom90days extends WeightChartWidget {

  final List<Weight> _weights;


  const WeightChartWidgetFrom90days(this._weights, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return LineChart(showLineChartData(_weights,context));
  }

}