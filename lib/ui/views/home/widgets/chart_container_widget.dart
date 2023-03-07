import 'package:weight_app/business_logic/view_model/chart_viewmodel.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:flutter/material.dart';

class ChartContainerWidget extends StatelessWidget {
  const ChartContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChartViewModel>(
      model: ChartViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, child) {
        return model.busy
            ? const CircularProgressIndicator()
            : Column(
                children: [Text('Column')],
              );
      },
    );
  }
}
