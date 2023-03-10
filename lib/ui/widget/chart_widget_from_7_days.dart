import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';

import '../../model/weight_model.dart';

class WeightChartWidgetFrom7days extends WeightChartWidget {

  WeightChartWidgetFrom7days({super.key});

  @override
  Widget build(BuildContext context) {
    print('Chart_widget_from_7_days | build');
    return showLineChart(context);
  }
}
