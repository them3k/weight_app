import 'package:equatable/equatable.dart';

class Weight extends Equatable{

  final double value;
  final DateTime dateEntry;

  Weight({required this.value, required this.dateEntry});

  @override
  String toString() {
    return 'Weight : ${value}kg | ${dateEntry.year}-${dateEntry.month}-${dateEntry.day} ';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [value,dateEntry];

}