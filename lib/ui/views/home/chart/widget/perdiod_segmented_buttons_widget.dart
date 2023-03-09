import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import '../../../../../business_logic/utils/constants.dart';
import '../../../../../model/periods.dart';

class PeriodSegmentedButtonWidget extends StatefulWidget {
  const PeriodSegmentedButtonWidget({Key? key}) : super(key: key);

  @override
  State<PeriodSegmentedButtonWidget> createState() =>
      _PeriodSegmentedButtonWidgetState();
}

class _PeriodSegmentedButtonWidgetState
    extends State<PeriodSegmentedButtonWidget> {
  Periods _period = Periods.weekly;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 11);
    return SegmentedButton<Periods>(
      segments: const <ButtonSegment<Periods>>[
        ButtonSegment<Periods>(
            value: Periods.weekly, label: Text(Constants.WEEKLY_NAME_NUM,style: textStyle,)),
        ButtonSegment<Periods>(
            value: Periods.monthly, label: Text(Constants.MONTHLY_NAME_NUM,style: textStyle,)),
        ButtonSegment<Periods>(
            value: Periods.quarterly, label: Text(Constants.QUATERLY_NAME_NUM,style: textStyle,)),
        ButtonSegment<Periods>(
            value: Periods.semiAnnually, label: Text(Constants.SEMI_ANNUALY_NAME_NUM,style: textStyle,)),
      ],
      // [
      //   ...periods.map((e) => ButtonSegment(
      //       value: e,
      //       label: Text('${e.name}',
      //         style: textStyle,)))
      selected: <Periods>{_period},
      onSelectionChanged: (Set<Periods> newSelection) {
        setState(() {
          print('Period Segmented Button | onSelectionChanged');
          _period = newSelection.first;
        });
        context.read<ChartsModel>().togglePeriod(newSelection.first);
      },
    );
  }
}
