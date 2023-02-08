import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/ui/views/add_page.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/ui/views/update_page.dart';
import '../widget/weight_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late WeightViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<WeightViewModel>(context, listen: false);
  }


  void onLongItemPress(int index) {
    print('Item with index: $index is pressed');
    var result = _viewModel.checkIfIsSelected(index);
    setState(() {
      result ? _viewModel.removeSelectedIndex(index) : _viewModel.selectItem(index);
    });
    print('HomePage | onItemPress | selectedIndexes: ');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeightViewModel>(builder: (context, model, child) {
      return ListView.builder(
          itemCount: model.weights.length,
          itemBuilder: (context, position) {
            return WeightItem(
              item: model.weights[position],
              onLongItemPress: onLongItemPress,
              onItemPressed: (int position) {
                navigateToUpdatePage(model.getItemAtIndex(position)!, position);
              },
              index: position,
              isPressed: _viewModel.checkIfIsSelected(position),
              isGreater: model.isWeightGrater(position, position - 1),
            );
          });
    });
  }
  void navigateToUpdatePage(Weight item, int index) {
    Navigator.of(context).push(MaterialPageRoute<UpdatePage>(
        builder: (_) => UpdatePage(item: item, index: index)));
  }
}
