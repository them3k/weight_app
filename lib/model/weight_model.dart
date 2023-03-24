class Weight{

  final double value;
  final DateTime dateEntry;

  Weight({required this.value, required this.dateEntry});

  @override
  String toString() {
    return 'Weight : ${value}kg | ${dateEntry.year}-${dateEntry.month}-${dateEntry.day} ';
  }

}