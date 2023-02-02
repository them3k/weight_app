import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../business_logic/utils/utils.date_format.dart';
import '../../model/weight_model.dart';


abstract class WeightChartWidget extends StatelessWidget{

  const WeightChartWidget({super.key});

  @override
  Widget build(BuildContext context);

  LineChartData showLineChartData(List<Weight> weights) {
    List<FlSpot> spots = convertToDaysFlSpot(weights);
    DateTime now = DateTime.now();
    spots.sort((a,b) => a.x.compareTo(b.x));
    print('weight_chart | showLineChartData | weight.len: ${weights.length} | spots.len: ${spots.length}');
    print('weight_chart | showLineChartData | spots: ${spots}');
    print('0.3: ${(weights.length * 0.3).floorToDouble()}');
    return LineChartData(
      borderData: FlBorderData(
          border: const Border(bottom: BorderSide(), left: BorderSide())),
      gridData: FlGridData(
          show: true, drawVerticalLine: true, horizontalInterval: 1,),
      titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 1,
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return buildBottomTitleWidgets(value, meta, weights,now);
                  },
              )),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 28,
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
              ))),
      minY: countMinY(spots),
      maxY: countMaxY(spots),
      minX: countMinX(weights),
      maxX: countMaxX(weights),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 4,
        )
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta){

    if (value == meta.min) return Container();

    return Text(value.toInt().toString());
  }

  Widget buildBottomTitleWidgets(double value, TitleMeta meta, List<Weight> weights,DateTime now) {

    print('Weight_Chart | buildBottomTitle | $value');
    Widget xTitleWidget;

    if (value == meta.min) {
      xTitleWidget = showXTitle(weights[value.toInt()].dateEntry, now);
    }else if (value == meta.max) {
      xTitleWidget =  showXTitle(weights[value.toInt()].dateEntry, now);
    }else if (value == (weights.length * 0.3).floorToDouble()) {
      xTitleWidget =  showXTitle(weights[value.toInt()].dateEntry, now);
    }else if (value == (weights.length * 0.6).toInt()) {
      xTitleWidget =  showXTitle(weights[value.toInt()].dateEntry, now);
    }else {
      xTitleWidget = Container();
    }
    return xTitleWidget;
  }

  Widget showXTitle(DateTime weightDateTime, DateTime now) {
    return Text(DateFormat.displayDateXAxis(weightDateTime, now));
  }



  double countMinY(List<FlSpot> spots){
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

  double? countMinX(List<Weight> weights){
    return 0;
  }

  double? countMaxX(List<Weight> weights){
    return weights.length -1;
  }

  List<FlSpot> convertToDaysFlSpot(List<Weight> weights) {
    List<FlSpot> spots = [];
    for (int i = 0; i < weights.length; i++) {
      spots.add(FlSpot(i.toDouble(), weights[i].value));
    }
    return spots;
  }


}