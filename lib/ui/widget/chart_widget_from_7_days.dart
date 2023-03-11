import 'package:flutter/material.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';

class WeightChartWidgetFrom7days extends WeightChartWidget {

  const WeightChartWidgetFrom7days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Chart_widget_from_7_days | build');
    return showLineChart(context);
  }
}
