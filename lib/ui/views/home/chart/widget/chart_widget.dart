import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/ui/views/home/chart/widget/empty_chart_info.dart';

import '../../../../../business_logic/view_model/charts_model.dart';
import '../../../../../model/periods.dart';
import '../../../../widget/chart_widget_from_180days.dart';
import '../../../../widget/chart_widget_from_30_days.dart';
import '../../../../widget/chart_widget_from_7_days.dart';
import '../../../../widget/chart_widget_from_90_days.dart';

class ChartWidget extends StatelessWidget {

  final Periods period;
  const ChartWidget({Key? key, required this.period}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16, left: 16),
        height: 200,
        child: _showChart(period));
  }
}



Widget _showChart(Periods period) {
  print('Charts_wiedget | showChart | $period');
  switch (period) {
    case Periods.weekly:
      return  WeightChartWidgetFrom7days();
    case Periods.monthly:
      return  WeightChartWidgetFrom30days();
    case Periods.quarterly:
      return  WeightChartWidgetFrom90days();
    case Periods.semiAnnually:
      return  WeightChartWidgetFrom180days();
    default:
      return Text('Unsupported period $period');
  }
}
