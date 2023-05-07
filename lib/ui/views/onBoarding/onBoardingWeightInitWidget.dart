import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/onboarding_view_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';

class OnBoardingWeightInitWidget extends StatefulWidget {

  Function onIncrement;

  OnBoardingWeightInitWidget({Key? key, required this.onIncrement})
      : super(key: key);

  @override
  State<OnBoardingWeightInitWidget> createState() =>
      _OnBoardingWeightInitWidgetState();
}

class _OnBoardingWeightInitWidgetState
    extends State<OnBoardingWeightInitWidget> {
  double _sliderValue = 0;

  @override
  void dispose() {
    print('on_boarding_weightInitWidget | dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              'lib/assets/images/weight_icon.png',
              height: 80,
              width: 80,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'How much do you weight ?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(_sliderValue.truncateToDouble())}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  ' kg',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Slider(
                  min: 0,
                  max: 300,
                  value: _sliderValue,
                  onChanged: (value) => setState(() {
                        _sliderValue = value;
                      })),
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
              onPressed: () {
                context.read<WeightModel>().saveInitWeight(_sliderValue);
                widget.onIncrement();
              },
              child: Text('Next',style: Theme.of(context).textTheme.labelMedium,)),
        )
      ],
    );
  }
}
