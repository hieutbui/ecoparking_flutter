import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/mixin_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin FacebookAuthMixin {
  Future<bool> signInWithFacebook() async {
    return await SupabaseUtils().auth.signInWithOAuth(
          OAuthProvider.facebook,
          redirectTo: PlatformInfos.isWeb
              ? MixinUtils().getRedirectURL()
              : 'io.supabase.flutterquickstart://login-callback/',
          authScreenLaunchMode: PlatformInfos.isWeb
              ? LaunchMode.platformDefault
              : LaunchMode.externalApplication,
        );
  }
}
