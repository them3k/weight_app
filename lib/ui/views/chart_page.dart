import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/ui/widget/weight_chart.dart';
import 'package:weight_app/ui/widget/chart_widget_from_7_days.dart';

import '../../business_logic/view_model/chart_viewmodel.dart';
import '../../model/hive/models/weight.dart';
import '../widget/chart_widget_from_30_days.dart';
import '../widget/chart_widget_from_90_days.dart';

enum Period { days180, days90, days30, days7 }

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChartViewModel>(
      create: (context) => ChartViewModel()..loadData(),
      child: Consumer<ChartViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Weight Chart'),
            ),
            body: viewModel.weights.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text('Add weight to display chart')),
                      ),
                      Icon(
                        Icons.add_chart,
                        size: 44,
                      )
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              periodPicker(
                                  text: '6 months',
                                  togglePeriod: () =>
                                      viewModel.togglePeriod(Period.days180),
                                  isPeriodPickerSelected: viewModel
                                      .isPeriodPickerSelected(Period.days180),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              periodPicker(
                                text: '3 months',
                                togglePeriod: () =>
                                    viewModel.togglePeriod(Period.days90),
                                isPeriodPickerSelected: viewModel
                                    .isPeriodPickerSelected(Period.days90),
                              ),
                              periodPicker(
                                text: '30 days',
                                togglePeriod: () =>
                                    viewModel.togglePeriod(Period.days30),
                                isPeriodPickerSelected: viewModel
                                    .isPeriodPickerSelected(Period.days30),
                              ),
                              periodPicker(
                                  text: '7 days',
                                  togglePeriod: () =>
                                      viewModel.togglePeriod(Period.days7),
                                  isPeriodPickerSelected: viewModel
                                      .isPeriodPickerSelected(Period.days7),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)))
                            ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8,right: 0,bottom: 8,top: 16),
                        height: 300,
                        child: _showChart(viewModel.period, viewModel.weights)
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  WeightChartWidget _showChart(Period period, List<Weight> weights) {
    switch (period) {
      case Period.days180:
        return WeightChartWidgetFrom90days(weights);
      case Period.days90:
        return WeightChartWidgetFrom90days(weights);
      case Period.days30:
        return WidgetChatWidgetFrom30days(weights);
      case Period.days7:
        return WeightChartWidgetFrom7days(weights);
      default:
        return WeightChartWidgetFrom7days(weights);
    }
  }


  Widget periodPicker(
      {required String text,
      required Function togglePeriod,
      required bool isPeriodPickerSelected,
      BorderRadius borderRadius = BorderRadius.zero}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => togglePeriod(),
        child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                color:
                    isPeriodPickerSelected ? Colors.blueAccent : Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: borderRadius),
            child: Text(text)),
      ),
    );
  }

}
