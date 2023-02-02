import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart' as intl;

class HalfCircleChart extends StatelessWidget {
  const HalfCircleChart({
    super.key,
    required double minimum,
    required double goal,
    required double progressValue,
  }) : _minimum = minimum, _goal = goal, _progressValue = progressValue;

  final double _minimum;
  final double _goal;
  final double _progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            minimum: _minimum.floorToDouble(),
            maximum: _goal.floorToDouble(),
            numberFormat: intl.NumberFormat.compact(),
            showLabels: false,
            showTicks: false,
            startAngle: 180,
            endAngle: 0,
            radiusFactor: 1.4,
            centerY: 0.8,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              color: Theme.of(context).colorScheme.primaryContainer,
              thicknessUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothCurve,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  color: Theme.of(context).colorScheme.primary,
                  value: _progressValue,
                  width: 0.2,
                  sizeUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.bothCurve),
            ],
            annotations: [
              GaugeAnnotation(
                angle: 0,
                widget: Text(
                  '$_goal kg',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                positionFactor: 1,
                verticalAlignment: GaugeAlignment.near,
              ),
              GaugeAnnotation(
                angle: 180,
                horizontalAlignment: GaugeAlignment.center,
                widget: Text(
                  '$_minimum kg',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                positionFactor: 1,
                verticalAlignment: GaugeAlignment.near,
              )
            ],
          )
        ],
      ),
    );
  }
}
