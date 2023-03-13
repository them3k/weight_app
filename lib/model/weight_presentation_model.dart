import 'package:weight_app/model/weight_model.dart';

import '../business_logic/utils/utils.date_format.dart';

class WeightPresentation {
  final String value;
  final String dateEntry;

  WeightPresentation(this.value, this.dateEntry);

  static WeightPresentation toPresentation(Weight item) {
    return WeightPresentation(
        item.value.toString(), DateFormat.displayDate(item.dateEntry));
  }

  static Weight formPresentation(WeightPresentation item) {
    return Weight(
        value: parseWeight(item.value),
        dateEntry: DateTime.parse(item.dateEntry));
  }

  static List<WeightPresentation> preparePresentation(List<Weight> list) {
    if (list.isEmpty) {
      return [];
    }

    List<WeightPresentation> weightPresentationList = [];

    list.sort((a, b) => a.dateEntry.compareTo(b.dateEntry));

    for (Weight weight in list) {
      weightPresentationList.add(toPresentation(weight));
    }
    return weightPresentationList;
  }

  static double parseWeight(String value) {
    if (value.isEmpty) {
      return -1;
    }
    return double.parse(value.replaceAll(',', '.'));
  }
}
