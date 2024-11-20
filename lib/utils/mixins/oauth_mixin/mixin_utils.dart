import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';

class MixinUtils {
  String getRedirectURL() {
    if (PlatformInfos.isRelease) {
      if (EnvLoader.isRelease) {
        return '${AppConfig.releaseDomain}/${EnvLoader.releaseTag}';
      } else {
        return '${AppConfig.repositoryURL}/${EnvLoader.pullRequestNumber}';
      }
    } else {
      return AppConfig.localRedirectURL;
    }
  }
}
