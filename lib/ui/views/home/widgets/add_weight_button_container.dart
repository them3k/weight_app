import 'package:flutter/material.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/ui/views/edit/edit_view.dart';

class AddWeightButtonContainer extends StatelessWidget {

  final Weight? item;
  final int? index;

  const AddWeightButtonContainer({this.item,this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16,bottom: 8),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToAddPage(context),
        child: Text('Add Weight'),
      ),
    );
  }

  void navigateToAddPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<EditView>(builder: (_) => EditView(item: item,index: index,)));
  }
}
