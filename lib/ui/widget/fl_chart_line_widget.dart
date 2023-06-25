import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weight_app/colors.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/chart.dart';
import '../../model/weight_model.dart';

class FLChartLineWidget extends StatelessWidget {

  final Chart chartData;

  const FLChartLineWidget({
    super.key,
    required this.chartData
  });

  @override
  Widget build(BuildContext context) {
    print('fl_chart_line_widget | build');
      return LineChart(LineChartData(
        borderData: _buildFlBorderData(),
        gridData: _buildFlGridData(),
        titlesData: _buildFlTitlesData(),
        lineTouchData: _buildLineTouchData(),
        minY: chartData.minY,
        maxY: chartData.maxY,
        minX: chartData.minX,
        maxX: chartData.maxX,
        lineBarsData: [_buildLineChartBarData()],
      ));
  }

  FlBorderData _buildFlBorderData() => FlBorderData(
      border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4))));

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
        belowBarData: _buildAreaData(),
        spots: chartData.spots,
        color: lightColorScheme.primary,
        isCurved: true,
        barWidth: 0.3,
        dotData: FlDotData(show: true));
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
      double value, TitleMeta meta, List<Weight> weights, DateTime now,double maxX) {
   // DateTime dateEntry = weights[value.toInt()].dateEntry;

    print('fl_chart_line_widget | buildBottomTitleWidgets | value: $value');

    if (meta.min == value) {
      return Container(
        margin: const EdgeInsets.only(left: 20),
        child: showXTitle(now.subtract(Duration(days: (maxX.toInt()))), now)
      );
    }


    return showXTitle(calculateBottomTitleDate(now, value,maxX), now);
  }
  // 1) reverset list
  // 2) substract max - days
  DateTime calculateBottomTitleDate(DateTime now, double value, double maxX) {
    print('fl_chart_line_widget | calculateBottomTitleDate |  maxX: ${maxX}');
    int days = maxX.toInt() - value.toInt();
    print('fl_chart_line_widget | calculateBottomTitleDate| value: $value | date: ${now.subtract(Duration(days: days))}');
    return now.subtract(Duration(days: days));
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
        interval: chartData.rightTitleInterval,
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
        interval: chartData.bottomTitleInterval,
        showTitles: true,
        getTitlesWidget: (double value, TitleMeta meta) {
          return buildBottomTitleWidgets(value, meta, chartData.weights, chartData.now,chartData.maxX);
        },
      ));

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.white
      )
    );
  }
}
