import 'package:ecoparking_flutter/config/app_config.dart';
import 'package:ecoparking_flutter/config/env_loader.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin GoogleAuthMixin {
  Future<bool> signInWithGoogleOnWeb() async {
    return await SupabaseUtils().auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: _getRedirectURL(),
          authScreenLaunchMode: PlatformInfos.isWeb
              ? LaunchMode.platformDefault
              : LaunchMode.externalApplication,
        );
  }

  String _getRedirectURL() {
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
