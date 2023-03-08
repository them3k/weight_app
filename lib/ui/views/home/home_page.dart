import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/charts_model.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/ui/views/home/widgets/add_weight_button_container.dart';
import 'package:weight_app/ui/views/home/widgets/chart_container_widget.dart';
import 'package:weight_app/ui/views/home/widgets/chart_widget.dart';
import 'package:weight_app/ui/views/home/widgets/congrat_widget.dart';
import 'package:weight_app/ui/views/home/widgets/current_weight_widget.dart';
import 'package:weight_app/ui/views/home/widgets/perdiod_segmented_buttons_widget.dart';

import '../../../model/periods.dart';
import '../../../model/weight_model.dart';
import '../../widget/chart_widget_from_7_days.dart';
import '../add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
