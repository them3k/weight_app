import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/weight_model.dart';

abstract class WeightChartWidget extends StatelessWidget {
  const WeightChartWidget({super.key});

  @override
  Widget build(BuildContext context);

  LineChartData showLineChartData(List<Weight> weights, BuildContext context) {
    List<FlSpot> spots = convertToDaysFlSpot(weights);
    DateTime now = DateTime.now();
    spots.sort((a, b) => a.x.compareTo(b.x));
    print(
        'weight_chart | showLineChartData | weight.len: ${weights.length} | spots.len: ${spots.length}');
    print('weight_chart | showLineChartData | spots: ${spots}');
    print('0.3: ${(weights.length * 0.3).floorToDouble()}');
    return LineChartData(
      borderData: FlBorderData(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))),
      gridData: FlGridData(
          getDrawingVerticalLine: (value) {
            return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1);
          },
          show: true,
          drawVerticalLine: true,
          verticalInterval: 1,
          drawHorizontalLine: false),
      titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: 1,
            reservedSize: 62,
            showTitles: true,
            getTitlesWidget: rightTitleWidgets,
          )),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return buildBottomTitleWidgets(value, meta, weights, now);
            },
          )),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      minY: countMinY(spots),
      maxY: countMaxY(spots),
      minX: countMinX(weights),
      maxX: countMaxX(weights),
      lineBarsData: [
        LineChartBarData(
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Theme.of(context).colorScheme.primary]
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
          spots: spots,
          color: Theme.of(context).colorScheme.primary,
          isCurved: true,
          barWidth: 2,
        )
      ],
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.min) return Container();
    print('Weight_chart | RightTitle | $value');
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: Text(
          '${value.toInt()} kg',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  Widget buildBottomTitleWidgets(
      double value, TitleMeta meta, List<Weight> weights, DateTime now) {
    print('Weight_Chart | buildBottomTitle | $value');
    Widget xTitleWidget;

    if (value == meta.min) {
      xTitleWidget = showXTitle(weights[value.toInt()].dateEntry, now);
    } else if (value == meta.max) {
      xTitleWidget = showXTitle(weights[value.toInt()].dateEntry, now);
    } else if (value == (weights.length * 0.3).floorToDouble()) {
      xTitleWidget = showXTitle(weights[value.toInt()].dateEntry, now);
    } else if (value == (weights.length * 0.6).toInt()) {
      xTitleWidget = showXTitle(weights[value.toInt()].dateEntry, now);
    } else {
      xTitleWidget = Container();
    }
    return xTitleWidget;
  }

  Widget showXTitle(DateTime weightDateTime, DateTime now) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          DateFormat.displayDateXAxis(weightDateTime, now),
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  double countMinY(List<FlSpot> spots) {
    List<double> ySpots = [];
    for (var spot in spots) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(min) - 2;
  }

  double countMaxY(List<FlSpot> spots) {
    List<double> ySpots = [];
    for (var spot in spots) {
      ySpots.add(spot.y);
    }
    return ySpots.reduce(max) + 2;
  }

  double? countMinX(List<Weight> weights) {
    return 0;
  }

  double? countMaxX(List<Weight> weights) {
    return weights.length - 1;
  }

  List<FlSpot> convertToDaysFlSpot(List<Weight> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      spots.add(FlSpot(i.toDouble(), weights[i].value.floorToDouble()));
    }
    return spots.toSet().toList();
  }
}
