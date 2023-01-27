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
    return Container(
      margin: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            width: double.infinity,
          ),
          InkWell(
            onTap: () => onItemPressed(index),
            onLongPress: () => onLongItemPress(index),
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color:  isPressed ? Colors.grey : Colors.white
              ),
              padding: const EdgeInsets.all(8),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('${item.value} kg'), Text(item.dateEntry)],
              ),
            ),
          ),
          Positioned(
              left: -10,
              top: -10,
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: isGreater
                      ? const Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                          size: 34,
                        )
                      : const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: 34,
                        ))),
        ],
      ),
    );
  }
}
