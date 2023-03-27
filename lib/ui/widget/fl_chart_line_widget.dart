import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/colors.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/weight_model.dart';

class FLChartLineWidget extends StatelessWidget {
  double rightTitleInterval;
  double bottomTitleInterval;
  List<FlSpot> spots;
  List<Weight> weights;
  DateTime now;



  @override
  Widget build(BuildContext context) {
    return showLineChart(context);
  }

  Widget showLineChart(BuildContext context) {
    ChartsModel model = context.read();
    print('weights_chart | weights: ${model.filteredWeights}');
    print('weights_chart | spots: ${model.spots}');

    // This is a state;
    DateTime now = DateTime.now();
    return LineChart(LineChartData(
      borderData: _buildFlBorderData(),
      gridData: _buildFlGridData(),
      titlesData: _buildFlTitlesData(),
      minY: model.countMinY(),
      maxY: model.countMaxY(),
      minX: model.countMinX(),
      maxX: model.countMaxX(),
      lineBarsData: [_buildLineChartBarData(model.spots)],
    ));
  }

  FlBorderData _buildFlBorderData() => FlBorderData(
      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4))));

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots) {
    return LineChartBarData(
        belowBarData: _buildAreaData(),
        spots: spots,
        color: lightColorScheme.primary,
        isCurved: true,
        barWidth: 0.3,
        dotData: FlDotData(show: false));
  }

  BarAreaData _buildAreaData() => BarAreaData(
      show: true,
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.white, lightColorScheme.primary]
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ));

  Widget buildRightTitleWidgets(double value, TitleMeta meta) {
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: Text(
          '${value.toInt()} kg',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  Widget buildBottomTitleWidgets(
      double value, TitleMeta meta, List<Weight> weights, DateTime now) {
    DateTime dateEntry = weights[value.toInt()].dateEntry;

    if (meta.min == value) {
      return Container(
        margin: const EdgeInsets.only(left: 20),
        child: showXTitle(dateEntry, now),
      );
    }

    return showXTitle(dateEntry, now);
  }

  Widget showXTitle(DateTime weightDateTime, DateTime now) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          DateFormat.displayDateXAxis(weightDateTime, now),
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  FlGridData _buildFlGridData() => FlGridData(
      getDrawingVerticalLine: (value) {
        return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
      },
      show: true,
      drawVerticalLine: true,
      verticalInterval: 1,
      drawHorizontalLine: false);

  AxisTitles _buildRightTitles() => AxisTitles(
          sideTitles: SideTitles(
        interval: rightTitleInterval,
        reservedSize: 48,
        showTitles: true,
        getTitlesWidget: buildRightTitleWidgets,
      ));

  FlTitlesData _buildFlTitlesData() => FlTitlesData(
      show: true,
      rightTitles: _buildRightTitles(),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: _buildBottomTitlesTitle(),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)));

  AxisTitles _buildBottomTitlesTitle() => AxisTitles(
          sideTitles: SideTitles(
        interval: bottomTitleInterval,
        showTitles: true,
        getTitlesWidget: (double value, TitleMeta meta) {
          return buildBottomTitleWidgets(value, meta, weights, now);
        },
      ));
}
