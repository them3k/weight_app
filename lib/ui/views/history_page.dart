import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/ui/views/add_page.dart';
import 'package:weight_app/ui/views/chart_page.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/ui/views/update_page.dart';

import '../../business_logic/utils/constants.dart';
import '../widget/weight_item.dart';
import 'add_weight_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _selectedIndexes = [];

  bool checkIfIsSelected(int index) {
    return _selectedIndexes.contains(index);
  }

  void onLongItemPress(int index) {
    print('Item with index: $index is pressed');

    setState(() {
      checkIfIsSelected(index)
          ? _selectedIndexes.remove(index)
          : _selectedIndexes.add(index);
    });
    print('HomePage | onItemPress | selectedIndexes: $_selectedIndexes');
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<WeightViewModel>(
      builder: (context, model, child) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () =>
                        navigateToAddPage(context, Constants.NEW_ITEM),
                    child: const Icon(Icons.add),
                  ),
                  appBar: AppBar(actions: [
                    _selectedIndexes.isEmpty
                        ? const SizedBox()
                        : GestureDetector(
                      child: const Icon(Icons.delete),
                      onTap: () {
                        model.deleteWeight(_selectedIndexes);
                        setState(() {
                          _selectedIndexes = [];
                          print(
                              'HomePage | build | selectedIndex: $_selectedIndexes');
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () =>
                      {
                        Navigator.of(context).push<MaterialPageRoute>(
                            MaterialPageRoute(builder: (_) => ChartPage()))
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.show_chart)),
                    )
                  ], title: const Text('Home Page')),
                  body: ListView.builder(
                      itemCount: model.weights.length,
                      itemBuilder: (context, position) {
                        return WeightItem(
                          item: model.weights[position],
                          onLongItemPress: onLongItemPress,
                          onItemPressed: (int position) {
                            navigateToUpdatePage(model.getItemAtIndex(position)!, position);
                            },
                          index: position,
                          isPressed: checkIfIsSelected(position),
                          isGreater: model.isWeightGrater(
                              position, position - 1),
                        );
                      }));
            });

  }

  void navigateToAddPage(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute<AddPage>(
        builder: (_) => const AddPage()));
  }

  void navigateToUpdatePage(Weight item, int index) {
    Navigator.of(context).push(MaterialPageRoute<UpdatePage>(
        builder: (_) => UpdatePage(item: item, index: index)));
  }
}
