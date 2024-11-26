import 'package:ecoparking_flutter/model/hive_custom_adapter/geo_point_adapter.dart';
import 'package:ecoparking_flutter/model/hive_custom_adapter/shift_type_adapter.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveInitializer {
  static const String recentSearchesBoxName = 'recent_searches';

  static Future<void> init() async {
    if (PlatformInfos.isLinux) {
      Hive.init((await getApplicationSupportDirectory()).path);
    } else {
      await Hive.initFlutter();
    }

    _registerAdapters();
  }

  static void _registerAdapters() {
    Hive.registerAdapter(ParkingAdapter());
    Hive.registerAdapter(GeoPointAdapter());
    Hive.registerAdapter(ShiftPriceAdapter());
    Hive.registerAdapter(ShiftTypeAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
  }

  static Future<Box<Parking>> openRecentSearchesBox() async {
    return Hive.openBox<Parking>(recentSearchesBoxName);
  }

  static Future<void> closeBox(String boxName) async {
    final box = Hive.box(boxName);

    return await box.close();
  }
}
