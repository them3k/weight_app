import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';

class CurrentWeightWidget extends StatelessWidget {
  const CurrentWeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16),
      child: Container(
        alignment: Alignment.bottomLeft,
        height: 100,
        child: Column(
          children: [
            const Text(
              'Current Weight',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Consumer<WeightViewModel>(
              builder: (context, viewModel, child) => Text(
                '${viewModel.lastWeight} kg',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
