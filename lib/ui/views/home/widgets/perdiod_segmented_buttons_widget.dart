import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/view_model/chart_viewmodel.dart';
import '../../../../model/periods.dart';

class PeriodSegmentedButtonWidget extends StatelessWidget {
  const PeriodSegmentedButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 11);
    return Consumer<ChartViewModel>(
      builder: (context, viewModel, child) => Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SegmentedButton<Periods>(
            segments: [
              ...periods.map((e) => ButtonSegment(
                  value: e,
                  label: Text(
                    '${e.name}',
                    style: textStyle,
                  )))
            ],
            selected: <Periods>{viewModel.period},
            onSelectionChanged: (Set<Periods> newSelection) {
              viewModel.togglePeriod(newSelection.first);
            },
          )),
    );
  }
}
