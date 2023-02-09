import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/weight_model.dart';

abstract class WeightChartWidget extends StatelessWidget {
  WeightChartWidget({super.key});

  @override
  Widget build(BuildContext context);

  LineChartData showLineChartData(List<Weight> weights, BuildContext context) {
    List<FlSpot> spots = convertToDaysFlSpot(weights);
    double diff = countDiff(spots);
    double interval = countRightTitleInterval(diff.toInt());
    DateTime now = DateTime.now();
    spots.sort((a, b) => a.x.compareTo(b.x));
    return LineChartData(
      borderData: FlBorderData(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))),
      gridData: FlGridData(
          getDrawingVerticalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
          },
          show: true,
          drawVerticalLine: true,
          verticalInterval: 1,
          drawHorizontalLine: false),
      titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: countRightTitleInterval(diff.toInt()),
            reservedSize: 48,
            showTitles: true,
            getTitlesWidget: buildRightTitleWidgets,
          )),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: countBottomTitleInterval(weights.length),
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return buildBottomTitleWidgets(value, meta, weights, now);
            },
          )),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      minY: countMinY(getMinWeightValue(spots), interval),
      maxY: countMaxY(getMaxWeightValue(spots), interval),
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
            barWidth: 0.3,
            dotData: FlDotData(show: false))
      ],
    );
  }

  Widget buildRightTitleWidgets(double value, TitleMeta meta) {
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: Text(
          '${value.toInt()} kg',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  Widget buildBottomTitleWidgets(
      double value, TitleMeta meta, List<Weight> weights, DateTime now) {
    if (meta.min == value) {
      return Container(
        margin: const EdgeInsets.only(left: 20),
        child: showXTitle(weights[value.toInt()].dateEntry, now),
      );
    }

    return showXTitle(weights[value.toInt()].dateEntry, now);
  }

  Widget showXTitle(DateTime weightDateTime, DateTime now) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          DateFormat.displayDateXAxis(weightDateTime, now),
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  double getMinWeightValue(List<FlSpot> spots) {
    List<double> ySpots = [];
    for (var spot in spots) {
      ySpots.add(spot.y);
    }
    print('Weight_chart | min: ${ySpots.reduce(min)}');
    return ySpots.reduce(min);
  }

  double getMaxWeightValue(List<FlSpot> spots) {
    List<double> ySpots = [];
    for (var spot in spots) {
      ySpots.add(spot.y);
    }
    print('Weight_chart | max: ${ySpots.reduce(max)}');
    return ySpots.reduce(max);
  }

// interval nie ma wpływu na diff
  double countMaxY(double max, double interval) {
    if (isEven(max, interval)) {
      return (max += interval).toDouble();
    }

    return ((max / interval).toInt() * interval) + interval;
  }

  double countMinY(double min, double interval) {
    if (min - interval <= 0) {
      return 0;
    }

    if (isEven(min, interval)) {
      return (min -= interval).toDouble();
    }

    return ((min / interval).toInt() * interval) - interval;
  }

  bool isEven(double max, double interval) {
    return max.toInt() % interval == 0;
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

  double countDiff(List<FlSpot> spots) =>
      getMaxWeightValue(spots) - getMinWeightValue(spots);

  double countRightTitleInterval(int diff) {
    if (diff >= 0 && diff <= 4) {
      return 1;
    }

    if (diff >= 5 && diff <= 7) {
      return 2;
    }

    if (diff >= 8 && diff <= 10) {
      return 3;
    }

    if (diff >= 11 && diff <= 13) {
      return 4;
    }

    if (diff >= 14 && diff <= 16) {
      return 5;
    }

    if (diff >= 17 && diff <= 44) {
      return 10;
    }

    if (diff >= 45 && diff <= 74) {
      return 20;
    }

    if (diff >= 75 && diff <= 104) {
      return 30;
    }

    if (diff >= 105) {
      return 50;
    }

    return 1;
  }

  double countBottomTitleInterval(int length) {
    if (length <= 3) {
      return 1;
    }

    return (length - 1) / 2;
  }
}
