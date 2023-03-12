import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_widget.dart';
import 'package:weight_app/ui/views/home/chart/widget/empty_chart_info.dart';
import 'package:weight_app/ui/views/home/chart/widget/perdiod_segmented_buttons_widget.dart';

class ChartView extends StatelessWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        model: ChartsModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return model.busy
              ? Column(
                  children: const [SizedBox(), CircularProgressIndicator()],
                )
              : model.shouldDisplayChart()
                  ? Column(
                      children: [
                        const PeriodSegmentedButtonWidget(),
                        ChartWidget(period: model.period)
                      ],
                    )
                  : const EmptyChartInfo();
        });
  }
}
