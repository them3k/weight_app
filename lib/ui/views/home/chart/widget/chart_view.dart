import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/home/chart/widget/empty_chart_info.dart';
import 'package:weight_app/ui/views/home/chart/widget/perdiod_segmented_buttons_widget.dart';
import 'package:weight_app/ui/widget/fl_chart_line_widget.dart';
import 'package:weight_app/ui/widget/proxy_base_widget.dart';


class ChartView extends StatelessWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyBaseWidget<ChartsModel, WeightModel>(
        update: (context, weightsModel, chartsModel) {
          print('chart_view | build | update | weights: ${weightsModel.weights.length}');
          return chartsModel..loadData(weightsModel.weights);
        },
        model: ChartsModel(),
        // onModelReady: (model) => model.loadData([]),
        builder: (context, model, child) {
          return model.busy
              ? Column(
                  children: const [SizedBox(), CircularProgressIndicator()],
                )
              : model.shouldDisplayChart()
                  ? Column(
                      children: [
                        const PeriodSegmentedButtonWidget(),
                        Container(
                          margin: const EdgeInsets.only(top: 16, left: 16),
                          height: 200,
                          width: double.infinity,
                          child: FLChartLineWidget(chartData: model.chartData),
                        )
                      ],
                    )
                  : const EmptyChartInfo();
        });
  }
}
