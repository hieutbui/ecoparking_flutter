import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:hive/hive.dart';

class ShiftTypeAdapter extends TypeAdapter<ShiftType> {
  @override
  final int typeId = 4;

  @override
  ShiftType read(BinaryReader reader) {
    final int type = reader.readInt();
    return ShiftType.values[type];
  }

  @override
  void write(BinaryWriter writer, ShiftType obj) {
    writer.writeInt(obj.index);
  }
}
