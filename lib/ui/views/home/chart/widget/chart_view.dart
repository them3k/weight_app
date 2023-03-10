import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_widget.dart';
import 'package:weight_app/ui/views/home/chart/widget/perdiod_segmented_buttons_widget.dart';

class ChartContainerWidget extends StatelessWidget {
  const ChartContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChartsModel>(
        create: (context) => ChartsModel(),
        builder: (context, child) {
          final ChartsModel model = Provider.of(context);
         return Column(
            children: [
              model.busy
                  ? const SizedBox()
                  : const PeriodSegmentedButtonWidget(),
              ChartWidget(
                model: model,
                onModelReady: (model) => model.loadData(),
              )
            ],
          );
        });
  }
}
