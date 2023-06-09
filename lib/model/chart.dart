import 'package:fl_chart/fl_chart.dart';
import 'package:weight_app/model/weight_model.dart';

class Chart {

  DateTime now;
  List<FlSpot> spots;
  List<Weight> weights;
  double bottomTitleInterval;
  double rightTitleInterval;
  double diff;
  double minX;
  double maxX;
  double minY;
  double maxY;
  bool isFirstValue;

  Chart({
    required this.now,
    required this.spots,
    required this.weights,
    required this.bottomTitleInterval,
    required this.rightTitleInterval,
    required this.diff,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.isFirstValue
  });

  @override
  String toString() =>
      'Chart: now: $now \n spots: $spots \n weights: $weights \n bTitle: $bottomTitleInterval \n rTitle: $rightTitleInterval \n'
          ' diff: $diff \n bTitleInterval: $bottomTitleInterval \n minX: $minX \n maxX: $maxX \n minY: $minY \n maxY: $maxY \n isFirstValue: $isFirstValue' ;
}