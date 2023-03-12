import 'package:flutter/material.dart';

class EmptyChartInfo extends StatelessWidget {
  const EmptyChartInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text('Add weight to display chart')),
            ),
            Icon(
              Icons.add_chart,
              size: 44,
            )
          ],
        ),
      );
    }
  }
