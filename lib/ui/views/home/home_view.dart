import 'package:flutter/material.dart';
import 'package:weight_app/ui/bottom_navigation_bar.dart';
import 'package:weight_app/ui/views/home/widgets/home_view_header.dart';
import 'package:weight_app/ui/views/home/widgets/add_weight_button_container.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_view.dart';
import '../../../business_logic/utils/pages.dart';
import '../../widget/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage<HomeView>(
        key: ValueKey(Pages.homePath), name: Pages.homePath, child: HomeView());
  }

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
     return Scaffold(
      body: SizedBox(
          height: mediaQuery.size.height -
              kBottomNavigationBarHeight -
              mediaQuery.padding.top,
          child: Column(
            children: const [
              CustomAppBar(title: 'Home'),
              HomeViewHeader(),
              ChartView(),
              Spacer(),
              AddWeightButtonContainer()
            ],
          )),
       bottomNavigationBar: const BottomNavBar(),
    );
  }
}
