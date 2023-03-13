import 'package:flutter/material.dart';
import '../../../model/weight_presentation_model.dart';

class WeightItem extends StatelessWidget {
  const WeightItem({Key? key,
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
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)
          ),
          border: Border.all(
              color: Theme
                  .of(context)
                  .colorScheme
                  .outline
          )
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            Text('${item.value}',
              style: const TextStyle(fontWeight: FontWeight.bold),),
            const Text(' kg')
          ],
        ),
        trailing: Text(item.dateEntry),
        leading: isGreater
            ? const Icon(Icons.arrow_upward, size: 28,)
            : const Icon(Icons.arrow_downward, size: 28),
        iconColor: isGreater
            ? Colors.green
            : Colors.red,
        selected: isPressed,
        onTap: () => onItemPressed(index),
        onLongPress: () => onLongItemPress(index),
      ),
    );
  }
}
