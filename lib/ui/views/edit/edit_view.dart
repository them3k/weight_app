import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/edit_view_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import '../../../business_logic/utils/pages.dart';
import '../../../business_logic/utils/utils.date_format.dart';
import '../../../model/weight_model.dart';
import '../../widget/half_circle_chart.dart';

class EditView extends StatefulWidget {

  static MaterialPage page([int? index, Weight? item]) {
    return MaterialPage(
        key: ValueKey(Pages.editPath),
        name: Pages.editPath,
        child: EditView(index: index, item: item));
  }

  final Weight? item;
  final int? index;

  const EditView({this.index, this.item, Key? key}) : super(key: key);

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _weightController.text = widget.item!.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Edit', style: TextStyle( color: Theme.of(context).colorScheme.onPrimaryContainer,)),
      ),
      body: BaseWidget(
          model: EditViewModel(weight: widget.item, index: widget.index),
          onModelReady: (model) => model.loadData(),
          builder: (context, model, child) {
            return model.busy
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      const SizedBox(height: 16,),
                      HalfCircleChart(
                        minimum: model.minimum,
                        goal: model.goal,
                        progressValue: model.weightValue,
                      ),
                      const SizedBox(height: 16,),
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                {_buildWeightValueChangeDialog(context)},
                            child: Text(
                              '${model.weightValue} kg',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                DateFormat.ddMMMyyyy(model.date),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () => _pickDate(context),
                                  child: Text('pick date')),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                          height: 40,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: ElevatedButton(
                              onPressed: () => {
                                    context.read<WeightModel>().saveWeight(
                                        model.weightValue,
                                        model.date,
                                        model.index),
                                    Navigator.pop(context)
                                  },
                              child: const Text('Save')))
                    ],
                  );
          }),
    );
  }

  void _pickDate(BuildContext context) {
    DateTime now = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(1900),
            lastDate: now)
        .then((value) => context.read<EditViewModel>().pickDate(value));
  }

  Future _buildWeightValueChangeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (innerContext) => AlertDialog(
              title: const Text('Add Weight'),
              content: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Insert your current weight: '),
                    TextField(
                      decoration: const InputDecoration(suffixText: 'kg'),
                      autofocus: true,
                      controller: _weightController,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => {
                          context
                              .read<EditViewModel>()
                              .pickWeight(_weightController.text),
                          Navigator.of(innerContext).pop(true)
                        },
                    child: Text('Save')),
                TextButton(
                    onPressed: () => {Navigator.of(innerContext).pop(false)},
                    child: Text('Cancel')),
              ],
            ));
  }
}
