import 'package:flutter/material.dart';
import 'package:weight_app/business_logic/view_model/history_view_model.dart';
import 'package:weight_app/business_logic/view_model/weight_model.dart';
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
    var result = context.read<HistoryViewModel>().checkIfIsSelected(index);
    setState(() {
      result
          ? context.read<HistoryViewModel>().removeSelectedIndex(index)
          : context.read<HistoryViewModel>().selectItem(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print('History_view | dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final listHeight = mediaQuery.size.height - kBottomNavigationBarHeight - 90;
    return ProxyBaseWidget<HistoryViewModel, WeightModel>(
      update: (context, parentModel, model) =>
          model..loadData(parentModel.weights),
      //onModelReady: (model) => model.loadData(),
      model: HistoryViewModel(),
      builder: (context, model, child) {
        return Column(
          children: [
            HistoryAppBar(
              onDelete: () {
                context.read<WeightModel>().deleteWeights(model.selectedIndexes);
                model.onTapDeleteSelectedItems();
              },
              title: 'History',
              isItemSelected: model.isItemsSelected,
            ),
            model.busy
                ? const CircularProgressIndicator()
                : SizedBox(
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
                        })),
          ],
        );
      },
    );
  }

  void navigateToUpdatePage(Weight item, int index) {
    Navigator.of(context).push(MaterialPageRoute<EditView>(
        builder: (_) => EditView(item: item, index: index)));
  }
}
