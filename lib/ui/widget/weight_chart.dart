import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import 'package:weight_app/business_logic/view_model/charts_model.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/weight_model.dart';

abstract class WeightChartWidget extends StatelessWidget {

  const WeightChartWidget({super.key});

  @override
  Widget build(BuildContext context);

  Widget showLineChart(BuildContext context) {
    ChartsModel model = context.read();
    DateTime now = DateTime.now();
    //return Consumer<ChartsModel>(
      //builder: (context,model,child) {
        return LineChart(LineChartData(
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
              interval: model.countRightTitleInterval(),
              reservedSize: 48,
              showTitles: true,
              getTitlesWidget: buildRightTitleWidgets,
            )),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              interval: model.countBottomTitleInterval(),
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return buildBottomTitleWidgets(value, meta,model.weights, now);
              },
            )),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        minY: model.countMinY(),
        maxY: model.countMaxY(),
        minX: model.countMinX(),
        maxX: model.countMaxX(),
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
              spots: model.spots,
              color: Theme.of(context).colorScheme.primary,
              isCurved: true,
              barWidth: 0.3,
              dotData: FlDotData(show: false))
        ],
      ));
    //   },
    // );
  }

  Widget buildRightTitleWidgets(double value, TitleMeta meta) {
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: Text(
          '${value.toInt()} kg',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ));
  }

  Widget buildBottomTitleWidgets(double value, TitleMeta meta,List<Weight> weights, DateTime now) {

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

// interval nie ma wpływu na diff
}
