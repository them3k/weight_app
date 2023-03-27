import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/services/chart_service/chart_service_impl.dart';
import 'package:weight_app/ui/widget/fl_chart_line_widget.dart';

import '../../../../../model/periods.dart';
import '../../../../../model/weight_model.dart';
import '../../../../../service_locator.dart';
import '../../../../../services/chart_service/chart_service.dart';

class ChartWidget extends StatelessWidget {

  final Periods period;
  final List<Weight> weight;
  final DateTime now;

  const ChartWidget({super.key,
    required this.period,
    required this.weight,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}


