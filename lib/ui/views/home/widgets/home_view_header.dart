import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/ui/views/home/home_view.dart';

import '../../../../business_logic/view_model/home_view_model.dart';
import '../../../../business_logic/view_model/weight_model.dart';
import '../../../base_widget.dart';
import 'congrat_widget.dart';
import 'current_weight_widget.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<WeightModel, HomeViewModel>(
      create: (context) => HomeViewModel(),
      update: (ctx, weightModel, homeViewModel) {
        if (homeViewModel == null) {
          return HomeViewModel()..loadData(weightModel.weights);
        }
        return homeViewModel..loadData(weightModel.weights);
      },
      child: Consumer<HomeViewModel>(builder: (context, model, child) {
        return model.busy
            ? const CircularProgressIndicator()
            : Column(children: [
                CongratsWidget(
                    gainWeightFromLastWeek: model.gainedWeightFromLastWeek),
                CurrentWeightWidget(lastWeight: model.lastWeight),
              ]);
      }),
    );
  }
}
