import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  }

  static Future<Box<Parking>> openRecentSearchesBox() async {
    return Hive.openBox<Parking>(recentSearchesBoxName);
  }
}
