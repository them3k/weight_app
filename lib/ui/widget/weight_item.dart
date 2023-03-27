import 'package:flutter/material.dart';
import '../../model/weight_presentation_model.dart';

class WeightItem extends StatelessWidget {
  const WeightItem(
      {Key? key,
      required this.item,
      required this.onLongItemPress,
      required this.index,
      required this.isPressed,
      required this.onItemPressed,
      required this.isGreater})
      : super(key: key);

  final Function(int) onLongItemPress;
  final WeightPresentation item;
  final int index;
  final bool isPressed;
  final Function(int) onItemPressed;
  final bool isGreater;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant)),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            Text(
              '${item.value}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            Text(
              ' kg',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize
              ),
            )
          ],
        ),
        trailing: Text(item.dateEntry,style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize
        ),),
        leading: isGreater
            ? const Icon(
                Icons.arrow_upward,
                size: 28,
              )
            : const Icon(Icons.arrow_downward, size: 28),
        iconColor: isGreater ? Colors.green : Colors.red,
        selected: isPressed,
        onTap: () => onItemPressed(index),
        onLongPress: () => onLongItemPress(index),
      ),
    );
  }
}
