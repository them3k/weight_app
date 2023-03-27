import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/main_page.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 56,
        ),
        Container(
            alignment: Alignment.center,
            child: Text(
              'OnBoarding Screen',
              style: Theme.of(context).textTheme.displaySmall,
            )),
        SizedBox(height: 32,),
        Image.asset(
          'lib/assets/images/weight_icon.png',
          height: 100,
          width: 100,
        ),
        SizedBox(height: 32,),
        Text('Choose your weight goal',style: Theme.of(context).textTheme.headlineSmall,),
        SizedBox(height: 16,),
        Slider(
          min: 0,
            max: 300,
            value: _sliderValue,
            onChanged: (value) => setState(() {
                  _sliderValue = value;
                })),
        Text('${(_sliderValue.toStringAsPrecision(3))} kg',style: Theme.of(context).textTheme.headlineSmall,),
        Spacer(),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: ElevatedButton(onPressed: () => _navigateToHome(), child: Text('Next')))
      ],
    ));
  }

  void _navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute<MainPage>(builder: (context) => MainPage()));
  }
}
