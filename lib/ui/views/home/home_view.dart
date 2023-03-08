import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/ui/views/home/widgets/add_weight_button_container.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_view.dart';
import 'package:weight_app/ui/views/home/chart/widget/chart_widget.dart';
import 'package:weight_app/ui/views/home/widgets/congrat_widget.dart';
import 'package:weight_app/ui/views/home/widgets/current_weight_widget.dart';
import 'package:weight_app/ui/views/home/chart/widget/perdiod_segmented_buttons_widget.dart';

import '../../../model/periods.dart';
import '../../../model/weight_model.dart';
import '../../widget/chart_widget_from_7_days.dart';
import '../add_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarMaxHeight = Scaffold
        .of(context)
        .appBarMaxHeight ?? 56;

    return ChangeNotifierProvider<WeightViewModel>.value(
        value: WeightViewModel(),
        child:
        SizedBox(
          height: mediaQuery.size.height -
              kBottomNavigationBarHeight -
              mediaQuery.padding.top -
              appBarMaxHeight,
          child: Column(
            children: const [
              CongratsWidget(),
              CurrentWeightWidget(),
            //  PeriodSegmentedButtonWidget(),
              ChartContainerWidget(),
              Spacer(),
              AddWeightButtonContainer(),
            ],
          ),
        ));
  }

}
