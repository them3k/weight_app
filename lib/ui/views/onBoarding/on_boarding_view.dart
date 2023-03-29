import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/onboarding_view_model.dart';
import 'package:weight_app/ui/views/main_page.dart';
import 'package:weight_app/ui/views/onBoarding/onBoardingWeightInitWidget.dart';
import 'package:weight_app/ui/views/onBoarding/on_boading_goal_init_widget.dart';


/*
    I have to store 2 values
    1) current weight value
    2) weight goal !
 */

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double _currentPage = 0;


  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<OnBoardingViewModel>(
      create: (context) => OnBoardingViewModel(),
      builder: (context, child) {
        return Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 56,),
              SizedBox(
                height: heightScreen - 56,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page as double;
                    });
                  },
                  children: [
                    OnBoardingWeightInitWidget(onIncrement: incrementPage),
                    OnBoardingGoalInitWidget()
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: const EdgeInsets.only(right: 16, bottom: 16),
              //   child: ElevatedButton(
              //       onPressed: () => {
              //         context
              //             .read<OnBoardingViewModel>()
              //             .saveGoal(20),
              //         Navigator.of(context).pushReplacement(MaterialPageRoute<MainPage>(
              //             builder: (context) => MainPage()))
              //       },
              //       child: Text('Next')),
              // )
            ],
          ),
        ));
      },
    );
  }

  void incrementPage() {
    setState(() {
      _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    });
    print('on_boarding_view | incrementPage');
  }
}
