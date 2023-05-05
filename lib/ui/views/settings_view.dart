import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/dark_mode_model.dart';
import 'package:weight_app/business_logic/view_model/setting_view_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import 'package:weight_app/ui/widget/custom_app_bar.dart';

import '../../business_logic/utils/pages.dart';
import '../../model/weight_presentation_model.dart';
import '../bottom_navigation_bar.dart';

class SettingsView extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage<SettingsView>(
        key: ValueKey(Pages.settingsPath),
        name: Pages.settingsPath,
        child: SettingsView());
  }

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
                  //leading: const Icon(Icons.monitor_weight_outlined),
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<DarkModeModel>(
                builder: (context, model, child) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SwitchListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: Theme.of(context).colorScheme.primaryContainer,
                      title: const Text(
                        'DarkMode',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: model.isDark,
                      onChanged: (value) => model.toggleDarkMode()),
                ),
              )
            ],
          );
        });
  }

  Widget _buildSettingListTile(
      String text, Icon? leading, Icon? trailing, Function onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: () => _buildWeightValueChangeDialog(context),
        trailing: trailing,
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: leading,
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
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
                      decoration: const InputDecoration(suffixText: 'kg'),
                      autofocus: true,
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
