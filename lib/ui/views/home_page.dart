import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/chart_viewmodel.dart';

import '../../model/weight_model.dart';
import '../../service_locator.dart';
import '../widget/chart_widget_from_7_days.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final double BALLONS_IMAGE_WIDTH = 100;

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Periods { weekly, monthly, quarterly, semiAnnually }

extension PeriodsExtension on Periods {
  static const names = {
    Periods.weekly: '7 days',
    Periods.monthly: '30 days',
    Periods.quarterly: '90 days',
    Periods.semiAnnually: '180 days',
  };

  String? get name => names[this];
}

class _HomePageState extends State<HomePage> {

  final _weightValue = 79.9;

  final List<String> _choices = const ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  int _choiceIndex = 0;

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
          _buildCongratWidget(context),
          _buildCurrentWeightWidget(context),
          _buildPeriodSegmentedButtons(),
          _buildChartContainer(),
          _buildAddWeightButton(),
        ],
      ),
    );
  }

  Widget _buildCongratWidget(BuildContext context) {
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
                width: HomePage.BALLONS_IMAGE_WIDTH,
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
                  Text(
                    'You gain 3.4 kg in last week',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'lib/assets/images/ballons.png',
            width: HomePage.BALLONS_IMAGE_WIDTH,
            height: 120,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentWeightWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16),
      child: Container(
        alignment: Alignment.bottomLeft,
        height: 100,
        child: Column(
          children: [
            const Text(
              'Current Weight',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${_weightValue}kg',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            )
          ],
        ),
      ),
    );
  }

  Periods period = Periods.weekly;

  final List<Periods> _periods = const [
    Periods.weekly,
    Periods.monthly,
    Periods.quarterly,
    Periods.semiAnnually
  ];

  Widget _buildPeriodSegmentedButtons() {
    TextStyle textStyle = TextStyle(fontSize: 11);
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SegmentedButton<Periods>(
          segments: [
            ..._periods.map((e) => ButtonSegment(
                value: e,
                label: Text(
                  '${e.name}',
                  style: textStyle,
                )))
          ],
          selected: <Periods>{period},
          onSelectionChanged: (Set<Periods> newSelection) {
            setState(() {
              period = newSelection.first;
            });
          },
        ));
  }

  Widget _buildChartContainer() {
    return Consumer<ChartViewModel>(
        builder: (context, viewModel, child) => viewModel.weights.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Add weight to display chart')),
                  ),
                  Icon(
                    Icons.add_chart,
                    size: 44,
                  )
                ],
              )
            : Container(
                margin: const EdgeInsets.only(top: 16),
                height: 200,
                child: _showChart(period, viewModel.weights)));
  }

  Widget _showChart(Periods period, List<Weight> weights) {
    switch (period) {
      case Periods.weekly:
        return WeightChartWidgetFrom7days(weights);
      case Periods.monthly:
        return WeightChartWidgetFrom7days(weights);
      case Periods.quarterly:
        return WeightChartWidgetFrom7days(weights);
      case Periods.semiAnnually:
        return WeightChartWidgetFrom7days(weights);
      default:
        return Text('Unsupported period $period');
    }
  }

  Widget _buildAddWeightButton(){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16, top: 16),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {

        },
        child: Text('Add Weight'),
      ),
    );
  }
}
