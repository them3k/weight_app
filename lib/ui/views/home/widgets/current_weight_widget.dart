import 'package:flutter/material.dart';

class CurrentWeightWidget extends StatelessWidget {
  final double lastWeight;

  const CurrentWeightWidget({Key? key, required this.lastWeight})
      : super(key: key);

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
            Text(
              '${lastWeight} kg',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ],
        ),
      ),
    );
  }
}
