import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/model/weight.dart';
import 'package:weight_app/business_logic/utils/utils.date_format.dart';

class AddWeightPage extends StatefulWidget {
  const AddWeightPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<AddWeightPage> createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  late WeightViewModel _viewModel;
  late TextEditingController _tController;
  late DateTime _date;

  @override
  void initState() {
    _viewModel = Provider.of<WeightViewModel>(context,listen: false);
    updateValue(_viewModel.getItemAtIndex(widget.index));
    super.initState();
  }

  @override
  void dispose() {
    _tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Weight'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.date_range_rounded,
                  size: 32,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100)) ??
                          DateTime.now();
                      pickDate(newDate);
                    },
                    child: Text(
                      DateFormat.displayDate(_date),
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _tController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixText: 'kg',
                        labelText: 'Enter your weight'),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                saveItem(context);
              },
              child: const Text('Save', style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  void updateValue(Weight? weight) {
    _tController = TextEditingController(text: weight?.value.toString());
    DateTime now = DateTime.now();
    _date = weight?.dateEntry ?? DateTime(now.year,now.month,now.day);
  }

  void saveItem(BuildContext context) {

    double wValue = _viewModel.parseWeight(_tController.text);
    if (wValue == -1) {
      _dialogBuilder(context);
      return;
    }

    Weight weight = Weight(value: wValue, dateEntry: DateTime(_date.year,_date.month,_date.day));

    widget.index == -1
        ? _viewModel.addWeight(weight)
        : _viewModel.updateWeight(weight, widget.index);

    Navigator.of(context).pop();
  }



  void pickDate(DateTime newDate) {
    print('AddWeightPage | pickDate | newDate: $newDate ');
    setState(() {
      _date = newDate;
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: const Text('Alert dialog'),
            content: const Text('Please insert weight value to save'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }
}
