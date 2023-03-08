import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/utils/constants.dart';

import '../../../../business_logic/view_model/weight_viewmodel.dart';

class CongratsWidget extends StatelessWidget {
  final double gainWeightFromLastWeek;

  const CongratsWidget({Key? key, required this.gainWeightFromLastWeek})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ]),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Constants.BALLONS_IMAGE_WIDTH,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Congrats!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  _buildWeightProgressText(gainWeightFromLastWeek)
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'lib/assets/images/ballons.png',
            width: Constants.BALLONS_IMAGE_WIDTH,
            height: 120,
          ),
        ),
      ],
    );
  }

  Widget _buildWeightProgressText(double progressValue) {
    String text = '';

    if (progressValue > 0) {
      text = 'You gain ${progressValue.toStringAsFixed(2)} kg in last week';
    } else {
      text =
          'You lost ${progressValue.abs().toStringAsFixed(2)} kg in last week';
    }

    return Text(
      text,
      style: TextStyle(fontSize: 14),
    );
  }
}
