import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/business_logic/view_model/history_view_model.dart';

class HistoryAppBar extends StatefulWidget {
  final String title;
  final bool isItemSelected;
  final Function onDelete;

  const HistoryAppBar(
      {Key? key, required this.title, required this.isItemSelected,required this.onDelete})
      : super(key: key);

  @override
  State<HistoryAppBar> createState() => _HistoryAppBarState();
}

class _HistoryAppBarState extends State<HistoryAppBar> {

  bool isItemsSelected = false;


  @override
  void initState() {
    super.initState();
    if(isItemsSelected != widget.isItemSelected){
      setState(() {
        isItemsSelected = widget.isItemSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            widget.isItemSelected
                ? GestureDetector(
                    child: const Icon(Icons.delete),
                    onTap: () => widget.onDelete()
                  )
                : const SizedBox()
          ])),
    );
  }
}
