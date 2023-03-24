import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/setting_view_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:weight_app/ui/widget/custom_app_bar.dart';

import '../../model/weight_presentation_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _weightGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        model: SettingsViewModel(),
        onModelReady: (model) {
          model.loadData();
        },
        builder: (context, model, child) {
          _weightGoalController.text = model.goal.toString();
          return Column(
            children: [
              const CustomAppBar(title: 'Settings'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  onTap: () => _buildWeightValueChangeDialog(context),
                  trailing: const Icon(Icons.arrow_forward),
                  title: const Text(
                    'Change weight goal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.monitor_weight_outlined),
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          );
        });
  }

  Future _buildWeightValueChangeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (innerContext) => AlertDialog(
              title: const Text('Set Goal'),
              content: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Insert your current weight goal: '),
                    TextField(
                      controller: _weightGoalController,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => {
                          onSave(context),
                          Navigator.of(innerContext).pop(true),
                        },
                    child: const Text('Save')),
                TextButton(
                    onPressed: () => {Navigator.of(innerContext).pop(false)},
                    child: const Text('Cancel')),
              ],
            ));
  }

  void onSave(BuildContext context) {
    context
        .read<SettingsViewModel>()
        .updateGoal(WeightPresentation.parseWeight(_weightGoalController.text));
    print('onSave | goal weight: ${_weightGoalController.text}');
  }
}
