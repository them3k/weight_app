import '../business_logic/utils/constants.dart';

enum Periods { weekly, monthly, quarterly, semiAnnually }

extension PeriodsExtension on Periods {
  static const names = {
    Periods.weekly: Constants.WEEKLY_NAME_NUM,
    Periods.monthly: Constants.MONTHLY_NAME_NUM,
    Periods.quarterly: Constants.QUATERLY_NAME_NUM,
    Periods.semiAnnually: Constants.SEMI_ANNUALY_NAME_NUM,
  };

  String? get name => names[this];
}

const List<Periods> periods = [
  Periods.weekly,
  Periods.monthly,
  Periods.quarterly,
  Periods.semiAnnually
];