import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/view_model/chart_viewmodel.dart';
import '../../../../model/periods.dart';
import '../../../../model/weight_model.dart';
import '../../../widget/chart_widget_from_180days.dart';
import '../../../widget/chart_widget_from_30_days.dart';
import '../../../widget/chart_widget_from_7_days.dart';
import '../../../widget/chart_widget_from_90_days.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartViewModel>(
        builder: (context, viewModel, child) => viewModel.weights.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
        )
            : Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            height: 200,
            child: _showChart(viewModel.period, viewModel.weights)));
  }

  Widget _showChart(Periods period, List<Weight> weights) {
    switch (period) {
      case Periods.weekly:
        return WeightChartWidgetFrom7days(weights);
      case Periods.monthly:
        return WeightChartWidgetFrom30days(weights);
      case Periods.quarterly:
        return WeightChartWidgetFrom90days(weights);
      case Periods.semiAnnually:
        return WeightChartWidgetFrom180days(weights);
      default:
        return Text('Unsupported period $period');
    }
  }
}
