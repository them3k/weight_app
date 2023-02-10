import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/chart_viewmodel.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/ui/views/home/widgets/chart_container.dart';
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
    final appBarMaxHeight = Scaffold.of(context).appBarMaxHeight ?? 56;
    return Container(
      height: mediaQuery.size.height -
          kBottomNavigationBarHeight -
          mediaQuery.padding.top -
          appBarMaxHeight,
      child: Column(
        children: [
          const CongratsWidget(),
          const CurrentWeightWidget(),
          const PeriodSegmentedButtonWidget(),
          const ChartContainer(),
          _buildAddWeightButton(context),
        ],
      ),
    );
  }




  Widget _buildAddWeightButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToAddPage(context),
        child: Text('Add Weight'),
      ),
    );
  }

  void navigateToAddPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<AddPage>(builder: (_) => const AddPage()));
  }


}
