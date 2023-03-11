import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../business_logic/view_model/charts_model.dart';
import '../../../../../model/periods.dart';
import '../../../../widget/chart_widget_from_180days.dart';
import '../../../../widget/chart_widget_from_30_days.dart';
import '../../../../widget/chart_widget_from_7_days.dart';
import '../../../../widget/chart_widget_from_90_days.dart';

class ChartWidget extends StatelessWidget {

  final bool shouldDisplayChart;
  final Periods period;
  const ChartWidget({Key? key, required this.shouldDisplayChart, required this.period}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Consumer<ChartsModel>(
      //builder: (context, model, child) {
        print('Chart_widget | build');
        return shouldDisplayChart
            ? _buildChart(period)
            : _buildEmptyChartInfo();
    //   },
    // );
  }
}

Widget _buildChart(Periods period) {
  print('Charts_widget | _buildChart');
  return Container(
      margin: const EdgeInsets.only(top: 16, left: 16),
      height: 200,
      child: _showChart(period));
}

Widget _buildEmptyChartInfo() {
  print('Charts_widget | _buildEmptyChartInfo');
  return SizedBox(
    height: 200,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text('Add weight to display chart')),
        ),
        Icon(
          Icons.add_chart,
          size: 44,
        )
      ],
    ),
  );
}

Widget _showChart(Periods period) {
  print('Charts_wiedget | showChart');
  switch (period) {
    case Periods.weekly:
      return const WeightChartWidgetFrom7days();
    case Periods.monthly:
      return const WeightChartWidgetFrom30days();
    case Periods.quarterly:
      return const WeightChartWidgetFrom90days();
    case Periods.semiAnnually:
      return const WeightChartWidgetFrom180days();
    default:
      return Text('Unsupported period $period');
  }
}
