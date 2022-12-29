import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddWeightPage extends StatelessWidget {
  const AddWeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Weight'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: 200,
                child: const TextField(
                  decoration: InputDecoration(labelText: 'Enter your weight'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Text('kg')
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
