import 'dart:ffi';

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
    ChartViewModel _viewModel = Provider.of<ChartViewModel>(context,listen: true);

    return _viewModel.spots == null
        ? const CircularProgressIndicator()
        : _viewModel.spots!.isEmpty
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
                child: _showChart(_viewModel.period));
  }
}

Widget _showChart(Periods period) {
  switch (period) {
    case Periods.weekly:
      return WeightChartWidgetFrom7days();
    case Periods.monthly:
      return WeightChartWidgetFrom30days();
    case Periods.quarterly:
      return WeightChartWidgetFrom90days();
    case Periods.semiAnnually:
      return WeightChartWidgetFrom180days();
    default:
      return Text('Unsupported period $period');
  }
}
