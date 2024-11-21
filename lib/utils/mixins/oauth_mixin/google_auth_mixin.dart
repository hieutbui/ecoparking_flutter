import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/mixin_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin GoogleAuthMixin {
  Future<bool> signInWithGoogleOnWeb() async {
    return await SupabaseUtils().auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: MixinUtils().getRedirectURL(),
          authScreenLaunchMode: PlatformInfos.isWeb
              ? LaunchMode.platformDefault
              : LaunchMode.externalApplication,
        );
  }
}
