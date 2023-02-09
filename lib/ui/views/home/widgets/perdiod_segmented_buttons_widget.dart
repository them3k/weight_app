import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/view_model/chart_viewmodel.dart';
import '../../../../model/periods.dart';

class PeriodSegmentedButtonWidget extends StatefulWidget {
  const PeriodSegmentedButtonWidget({Key? key}) : super(key: key);

  @override
  State<PeriodSegmentedButtonWidget> createState() => _PeriodSegmentedButtonWidgetState();
}

class _PeriodSegmentedButtonWidgetState extends State<PeriodSegmentedButtonWidget> {
  Periods _period = Periods.weekly;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 11);
    return Container(
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
          selected: <Periods>{_period},
          onSelectionChanged: (Set<Periods> newSelection) {
            setState(() {
              _period = newSelection.first;
              context.read<ChartViewModel>().togglePeriod(_period);
            });
          },
        ));
  }
}
