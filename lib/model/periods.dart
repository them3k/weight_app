enum Periods { weekly, monthly, quarterly, semiAnnually }

extension PeriodsExtension on Periods {
  static const names = {
    Periods.weekly: '7 days',
    Periods.monthly: '30 days',
    Periods.quarterly: '90 days',
    Periods.semiAnnually: '180 days',
  };

  String? get name => names[this];
}

const List<Periods> periods = [
  Periods.weekly,
  Periods.monthly,
  Periods.quarterly,
  Periods.semiAnnually
];