import '../../model/periods.dart';
import '../../model/weight_model.dart';
import '../utils/constants.dart';

class WeightFilters {

  static List<Weight> filterItemsByDate(List<Weight> list, int days){
    DateTime diffDays = DateTime.now().subtract(Duration(days: days));
    return list.where((element) => element.dateEntry.millisecondsSinceEpoch > diffDays.millisecondsSinceEpoch).toList();
  }

  static List<Weight> filterWeeklyWeights(List<Weight> list){
    DateTime diffDays = DateTime.now().subtract(const Duration(days: Constants.WEEKLY));
    return list.where((element) => element.dateEntry.millisecondsSinceEpoch > diffDays.millisecondsSinceEpoch).toList();
  }

  static List<Weight> filterDataBasedOnPeriod(Periods period, List<Weight> weights)  {
    switch (period) {
      case Periods.semiAnnually:
        return filterItemsByDate(weights, Constants.SEMI_ANNUALLY);
      case Periods.quarterly:
        return filterItemsByDate(weights, Constants.QUATERLY);
      case Periods.monthly:
        return filterItemsByDate(weights, Constants.MONTHLY);
      case Periods.weekly:
        return filterItemsByDate(weights, Constants.WEEKLY);
      default:
        return [];
    }
  }
}