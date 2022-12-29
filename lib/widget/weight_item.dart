import 'package:flutter/material.dart';
import 'package:weight_app/utils.date_format.dart';
import '../model/weight.dart';

class WeightItem extends StatelessWidget {
  const WeightItem({Key? key,required this.item}) : super(key: key);

  final Weight item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${item.value} kg'),
        trailing: Text(DateFormat.displayDate(item.dateEntry)),
      ),
    );
  }
}
