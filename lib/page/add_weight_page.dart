import 'package:flutter/material.dart';
import 'package:weight_app/model/weight.dart';
import 'package:weight_app/utils.date_format.dart';

import '../repository/repository.dart';

class AddWeightPage extends StatefulWidget {
  const AddWeightPage({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  State<AddWeightPage> createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  TextEditingController tController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Weight'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)) ??
                    DateTime.now();

                pickDate(newDate);
              },
              child: Text(DateFormat.displayDate(date))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: 200,
                child: TextField(
                  controller: tController,
                  onSubmitted: (value) {},
                  decoration:
                      const InputDecoration(labelText: 'Enter your weight'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Text('kg')
            ],
          ),
          TextButton(
              onPressed: () {
                saveItem(context);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }

  void saveItem(BuildContext context) {
    double wValue = parseWeight(tController.text);
    if (wValue == -1) {
      _dialogBuilder(context);
      return;
    }
    Weight weight = Weight(value: wValue, dateEntry: date);
    widget.repository.addWeight(weight);
    Navigator.of(context).pop();
  }

  double parseWeight(String value) {
    if (value.isEmpty) {
      return -1;
    }
    return double.parse(value.replaceAll(',', '.'));
  }

  void pickDate(DateTime newDate) {
    setState(() {
      date = newDate;
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
