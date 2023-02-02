// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveWeightAdapter extends TypeAdapter<HiveWeight> {
  @override
  final int typeId = 0;

  @override
  HiveWeight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWeight(
      value: fields[0] as double,
      dateEntry: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWeight obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.dateEntry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWeightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
