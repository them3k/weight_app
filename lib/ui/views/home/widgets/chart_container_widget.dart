import 'package:weight_app/business_logic/view_model/chart_viewmodel.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/home/widgets/chart_widget.dart';
import 'package:weight_app/ui/views/home/widgets/perdiod_segmented_buttons_widget.dart';

class ChartContainerWidget extends StatelessWidget {
  const ChartContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChartViewModel>(
      model: ChartViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, child) {
            return Column(
                children: [
                  child!,
                  model.busy
                  ? const CircularProgressIndicator()
                  : const ChartWidget()
                ],
              );
      },
      child: const PeriodSegmentedButtonWidget(),
    );
  }
}
