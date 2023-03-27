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
  });

  @override
  String toString() =>
      'Chart: now: $now \n spots: $spots \n weights: $weights \n bTitle: $bottomTitleInterval \n rTitle: $rightTitleInterval \n'
          'diff: $diff \n  minX: $minX maxX: $maxX minY: $minY maxY: $maxY' ;
}