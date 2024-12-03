import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/mixin_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> nativeGoogleSign(String webClientId) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw Exception('No access token');
    }

    if (idToken == null) {
      throw Exception('No id token');
    }

    await SupabaseUtils().auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
  }
}
