import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../business_logic/view_model/charts_model.dart';
import '../../../../../model/periods.dart';
import '../../../../widget/chart_widget_from_180days.dart';
import '../../../../widget/chart_widget_from_30_days.dart';
import '../../../../widget/chart_widget_from_7_days.dart';
import '../../../../widget/chart_widget_from_90_days.dart';

class ChartWidget extends StatefulWidget {

  final ChartsModel model;
  final Function (ChartsModel)? onModelReady;

  const ChartWidget({Key? key, required this.model, this.onModelReady}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late ChartsModel model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartsModel>(
          builder: (context, model, child) {
            return model.busy
                ? const CircularProgressIndicator()
                : model.spots.isEmpty
                    ? SizedBox(
              height: 200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                    )
                    : Container(
                        margin: const EdgeInsets.only(top: 16, left: 16),
                        height: 200,
                        child: _showChart(model.period));
          },
        );
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
