import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/history_view_model.dart';
import 'package:weight_app/business_logic/view_model/weight_viewmodel.dart';
import 'package:weight_app/model/weight_model.dart';
import 'package:weight_app/model/weight_presentation_model.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/ui/widget/proxy_base_widget.dart';
import '../edit/edit_view.dart';
import 'history_view_app_bar.dart';
import 'weight_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  void onLongItemPress(int index) {
    print('Item with index: $index is pressed');
    var result = context.read<HistoryViewModel>().checkIfIsSelected(index);
    setState(() {
      result
          ? context.read<HistoryViewModel>().removeSelectedIndex(index)
          : context.read<HistoryViewModel>().selectItem(index);
    });
    print('HomePage | onItemPress | selectedIndexes: ');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final listHeight = mediaQuery.size.height - kBottomNavigationBarHeight - 90;
    return BaseWidget(
        model: HistoryViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return model.busy
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    HistoryAppBar(
                      title: 'History',
                      isItemSelected: model.isItemsSelected,
                    ),
                    SizedBox(
                      height: listHeight,
                      child: ListView.builder(
                          itemCount: model.weights.length,
                          itemBuilder: (context, position) {
                            return WeightItem(
                              item: WeightPresentation.toPresentation(
                                  model.weights[position]),
                              onLongItemPress: (int index) => {
                                setState(() {
                                  context
                                          .read<HistoryViewModel>()
                                          .checkIfIsSelected(index)
                                      ? context
                                          .read<HistoryViewModel>()
                                          .removeSelectedIndex(index)
                                      : context
                                          .read<HistoryViewModel>()
                                          .selectItem(index);
                                })
                              },
                              onItemPressed: (int position) {
                                navigateToUpdatePage(
                                    model.getItemAtIndex(position)!, position);
                              },
                              index: position,
                              isPressed: model.checkIfIsSelected(position),
                              isGreater:
                                  model.isWeightGrater(position, position - 1),
                            );
                          }),
                    ),
                  ],
                );
        });
  }

  void navigateToUpdatePage(Weight item, int index) {
    Navigator.of(context).push(MaterialPageRoute<EditView>(
        builder: (_) => EditView(item: item, index: index)));
  }
}
