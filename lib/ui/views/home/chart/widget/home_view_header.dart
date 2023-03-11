import 'package:flutter/material.dart';

import '../../../../../business_logic/view_model/home_view_model.dart';
import '../../../../base_widget.dart';
import '../../widgets/congrat_widget.dart';
import '../../widgets/current_weight_widget.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        model: HomeViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return model.busy
              ? const CircularProgressIndicator()
              : Column(children: [
                  CongratsWidget(
                      gainWeightFromLastWeek: model.gainedWeightFromLastWeek),
                  CurrentWeightWidget(lastWeight: model.lastWeight),
                ]);
        });
  }
}
