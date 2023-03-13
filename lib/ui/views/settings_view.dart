import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';

import '../../model/weight_presentation_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  final _weightGoalController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  void loadData() {
      _weightGoalController.text = context.read<WeightViewModel>().goal.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: () => _buildWeightValueChangeDialog(context),
        trailing: Icon(Icons.arrow_forward),
        title: Text('Change weight goal',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: Icon(Icons.monitor_weight_outlined),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );


  }

  Future _buildWeightValueChangeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (innerContext) => AlertDialog(
          title: Text('Set Goal'),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Insert your current weight goal: '),
                TextField(
                  controller: _weightGoalController,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => {
                  onSave(),
                  Navigator.of(innerContext).pop(true),
                },
                child: Text('Save')),
            TextButton(
                onPressed: () => {Navigator.of(innerContext).pop(false)},
                child: Text('Cancel')),
          ],
        ));
  }

  void onSave() {
    context.read<WeightViewModel>().updateGoal(WeightPresentation.parseWeight(_weightGoalController.text));
    print('onSave | goal weight: ${_weightGoalController.text}');
  }
}
