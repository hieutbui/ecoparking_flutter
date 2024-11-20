import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin GoogleAuthMixin {
  Future<bool> signInWithGoogleOnWeb() async {
    return await SupabaseUtils().auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo:
              PlatformInfos.isWeb ? null : AppPaths.profile.navigationPath,
          authScreenLaunchMode: PlatformInfos.isWeb
              ? LaunchMode.platformDefault
              : LaunchMode.externalApplication,
        );
  }
}
