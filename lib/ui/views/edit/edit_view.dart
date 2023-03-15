import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/edit_view_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
import 'package:weight_app/ui/base_widget.dart';
import '../../../business_logic/utils/utils.date_format.dart';
import '../../../business_logic/utils/wave_clipper.dart';
import '../../../model/weight_model.dart';
import '../../widget/half_circle_chart.dart';

class EditView extends StatefulWidget {
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
        title: Text('Edit'),
      ),
      body: BaseWidget(
          model: EditViewModel(weight: widget.item, index: widget.index),
          onModelReady: (model) => model.loadData(),
          builder: (context, model, child) {
            return model.busy
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      const Spacer(),
                      HalfCircleChart(
                        minimum: model.minimum,
                        goal: model.goal,
                        progressValue: model.weightValue,
                      ),
                      Stack(children: [
                        Container(
                          padding: const EdgeInsets.only(top: 60),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 0),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          height: mediaQuery.size.height -
                              56 -
                              mediaQuery.size.height * 0.3 -
                              mediaQuery.viewPadding.top,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () =>
                                    {_buildWeightValueChangeDialog(context)},
                                child: Text(
                                  '${model.weightValue} kg',
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Text(
                                    DateFormat.ddMMMyyyy(model.date),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
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
                        ),
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                border:
                                    Border.all(color: Colors.white, width: 0)),
                            height: mediaQuery.size.height -
                                56 -
                                mediaQuery.size.height * 0.3 -
                                mediaQuery.viewPadding.top,
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Container(
                                height: 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                    onPressed: () => {
                                          context
                                              .read<WeightModel>()
                                              .saveWeight(model.weightValue,
                                                  model.date, model.index),
                                          Navigator.pop(context)
                                        },
                                    child: const Text('Save'))))
                      ]),
                    ],
                  );
          }),
    );
  }

  void _pickDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
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
