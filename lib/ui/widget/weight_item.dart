import 'package:flutter/material.dart';
import '../../business_logic/view_model/weight_viewmodel.dart';

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
    return _buildWeightListTitle(context);
    // return Container(
    //   margin: EdgeInsets.all(16),
    //   child: Stack(
    //     clipBehavior: Clip.none,
    //     alignment: Alignment.center,
    //     children: [
    //       Container(
    //         height: 100,
    //         width: double.infinity,
    //       ),
    //       InkWell(
    //         onTap: () => onItemPressed(index),
    //         onLongPress: () => onLongItemPress(index),
    //         customBorder:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20),
    //               color: isPressed
    //               ? Theme.of(context).colorScheme.primaryContainer
    //               : Theme.of(context).colorScheme.surface,
    //               border: Border.all(
    //                 color: isPressed
    //                     ? Theme.of(context).colorScheme.outline
    //                     : Theme.of(context).colorScheme.primaryContainer,
    //               ),
    //           ),
    //           padding: const EdgeInsets.all(8),
    //           height: 100,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [Text('${item.value} kg'), Text(item.dateEntry)],
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //           left: -10,
    //           top: -10,
    //           child: Container(
    //               height: 40,
    //               width: 40,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(100)),
    //               child: isGreater
    //                   ? const Icon(
    //                       Icons.arrow_upward,
    //                       color: Colors.green,
    //                       size: 34,
    //                     )
    //                   : const Icon(
    //                       Icons.arrow_downward,
    //                       color: Colors.red,
    //                       size: 34,
    //                     ))),
    //     ],
    //   ),
    // );
  }

  Widget _buildWeightListTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10)
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline
        )
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            Text('${item.value}',style: const TextStyle(fontWeight: FontWeight.bold),),
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
