import 'package:flutter/material.dart';
import 'package:weight_app/ui/views/home/widgets/home_view_header.dart';
import 'package:weight_app/ui/views/home/widgets/add_weight_button_container.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_view.dart';
import 'package:weight_app/ui/views/home/widgets/congrat_widget.dart';
import 'package:weight_app/ui/views/home/widgets/current_weight_widget.dart';
import '../../../business_logic/view_model/home_view_model.dart';
import '../../base_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBarMaxHeight = Scaffold.of(context).appBarMaxHeight ?? 56;
    return SizedBox(
        height: mediaQuery.size.height -
            kBottomNavigationBarHeight -
            mediaQuery.padding.top -
            appBarMaxHeight,
        child: Column(
          children: const [
            HomeViewHeader(),
            ChartView(),
            Spacer(),
            AddWeightButtonContainer()
          ],
        ));
  }
}
