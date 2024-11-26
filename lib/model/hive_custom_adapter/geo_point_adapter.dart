import 'package:geobase/geobase.dart';
import 'package:hive/hive.dart';

class GeoPointAdapter extends TypeAdapter<Point> {
  @override
  final int typeId = 1;

  @override
  Point read(BinaryReader reader) {
    final double latitude = reader.readDouble();
    final double longitude = reader.readDouble();
    return Point(
      Position.create(
        x: longitude,
        y: latitude,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, Point obj) {
    writer
      ..writeDouble(obj.position.y)
      ..writeDouble(obj.position.x);
  }
}
