import 'package:hive/hive.dart';

part 'weight.g.dart';

@HiveType(typeId: 0)
class HiveWeight{

  @HiveField(0)
  final double value;
  @HiveField(1)
  final DateTime dateEntry;

  HiveWeight({required this.value, required this.dateEntry});

  @override
  String toString() {
    return 'Weight + $value + $dateEntry';
  }
  
}