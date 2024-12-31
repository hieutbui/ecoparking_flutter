import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/register_service.dart';
import 'package:ecoparking_flutter/domain/state/login/get_google_web_client_state.dart';
import 'package:ecoparking_flutter/domain/state/register/register_state.dart';
import 'package:ecoparking_flutter/domain/usecase/login/get_google_web_client_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/register/register_interactor.dart';
import 'package:ecoparking_flutter/pages/register/register_view.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/facebook_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/mixins/oauth_mixin/google_auth_mixin.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterController createState() => RegisterController();
}

class RegisterController extends State<RegisterPage>
    with ControllerLoggy, GoogleAuthMixin, FacebookAuthMixin {
  final RegisterInteractor _registerInteractor =
      getIt.get<RegisterInteractor>();
  final GetGoogleWebClientInteractor _getGoogleWebClientInteractor =
      getIt.get<GetGoogleWebClientInteractor>();

  final RegisterService _registerService = getIt.get<RegisterService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final registerStateNotifier = ValueNotifier<RegisterState>(
    const RegisterInitial(),
  );
  final googleWebClientNotifier = ValueNotifier<GetGoogleWebClientState>(
    const GetGoogleWebClientInitial(),
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  StreamSubscription? _registerSubscription;
  StreamSubscription? _authStateSubscription;
  StreamSubscription? _googleWebClientSubscription;

  @override
  void initState() {
    super.initState();
    _getGoogleWebClientId();
    _authStateSubscription = SupabaseUtils().auth.onAuthStateChange.listen(
      (data) {
        final session = data.session;
        if (session != null) {
          _handleAuthSuccess();
        }
      },
      onError: (error) {
        if (error is AuthException) {
          _showAuthError(error: error);
        } else {
          _showAuthError();
        }
      },
    );
  }

  @override
  void dispose() {
    _registerSubscription?.cancel();
    _authStateSubscription?.cancel();
    _googleWebClientSubscription?.cancel();
    emailController.text = '';
    passwordController.text = '';
    emailController.dispose();
    passwordController.dispose();
    registerStateNotifier.dispose();
    googleWebClientNotifier.dispose();
    super.dispose();
  }

  void _handleAuthSuccess() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.profile,
    );
  }

  void _showAuthError({
    AuthException? error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error?.message ?? 'Có lỗi xảy ra!',
        ),
      ),
    );
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void loginPressed() {
    loggy.info('loginPressed()');
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void onEmailChanged(String value) {
    loggy.info('onEmailChanged(): $value');
  }

  void onPasswordChanged(String value) {
    loggy.info('onPasswordChanged(): $value');
  }

  void onSignUpPressed() {
    loggy.info('onSignUpPressed()');
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _registerSubscription = _registerInteractor
          .execute(
            emailController.text,
            passwordController.text,
          )
          .listen(
            (result) => result.fold(
              _handleRegisterFailure,
              _handleRegisterSuccess,
            ),
          );
    } else {}
  }

  void _handleRegisterFailure(Failure failure) {
    loggy.error('_handleRegisterFailure(): $failure');
    if (failure is RegisterAuthFailure) {
      registerStateNotifier.value = failure;
    } else if (failure is RegisterOtherFailure) {
      registerStateNotifier.value = failure;
    } else {
      registerStateNotifier.value = const RegisterEmptyAuth();
    }

    _showRegisterFailureDialog();
  }

  void _handleRegisterSuccess(Success success) {
    loggy.info('_handleRegisterSuccess(): $success');
    if (success is RegisterSuccess) {
      registerStateNotifier.value = success;
      final user = success.authResponse.user;
      if (user != null) {
        _processRegistered(user);
      }
    } else {
      registerStateNotifier.value = const RegisterEmptyAuth();
    }
  }

  void _showRegisterFailureDialog() {
    loggy.info('_showRegisterFailureDialog()');
    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogError,
      title: 'Đăng ký thất bại!',
      description: 'Vui lòng thử lại!',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'OK',
            onPressed: () {
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _processRegistered(User user) {
    loggy.info('_processRegistered()');
    if (user.emailConfirmedAt != null) {
      DialogUtils.show(
        context: context,
        svgImage: ImagePaths.imgDialogSuccessful,
        title: 'Đăng ký thành công!',
        description: 'Email đã được xác nhận!',
        actions: (context) {
          return <Widget>[
            ActionButton(
              type: ActionButtonType.positive,
              label: 'Đăng nhập',
              onPressed: () {
                NavigationUtils.navigateTo(
                  context: context,
                  path: AppPaths.login,
                );
                DialogUtils.hide(context);
              },
            ),
          ];
        },
      );
    }

    _registerService.setUser(user);
    _showRegisterSuccessDialog();
  }

  void _showRegisterSuccessDialog() {
    loggy.info('showRegisterSuccessDialog()');

    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogSuccessful,
      title: 'Đăng ký thành công!',
      description: 'Mã xác nhận đã được gửi đến email của bạn!',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Xác thực',
            onPressed: () {
              NavigationUtils.navigateTo(
                context: context,
                path: AppPaths.registerVerify,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void onLoginWithGooglePressed() async {
    loggy.info('onLoginWithGooglePressed()');
    if (PlatformInfos.isWeb) {
      await signInWithGoogleOnWeb();
    } else {
      final String? googleWebClientId = _accountService.googleWebClientId;
      if (googleWebClientId != null) {
        await nativeGoogleSign(googleWebClientId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Không thể đăng nhập bằng Google, vui lòng thử lại sau'),
          ),
        );
      }
    }
  }

  void _getGoogleWebClientId() {
    _googleWebClientSubscription =
        _getGoogleWebClientInteractor.execute().listen(
              (event) => event.fold(
                _handleGetGoogleWebClientFailure,
                _handleGetGoogleWebClientSuccess,
              ),
            );
  }

  void _handleGetGoogleWebClientFailure(Failure failure) {
    loggy.error('handleGetGoogleWebClientFailure(): $failure');
    if (failure is GetGoogleWebClientFailure) {
      googleWebClientNotifier.value = failure;
    } else if (failure is GetGoogleWebClientEmpty) {
      googleWebClientNotifier.value = const GetGoogleWebClientEmpty();
    }
  }

  void _handleGetGoogleWebClientSuccess(Success success) {
    loggy.info('handleGetGoogleWebClientSuccess(): $success');
    if (success is GetGoogleWebClientSuccess) {
      googleWebClientNotifier.value = success;
      _accountService.setGoogleWebClientId(success.googleWebClient);
    } else if (success is GetGoogleWebClientLoading) {
      googleWebClientNotifier.value = success;
    }
  }

  void onLoginWithFacebookPressed() async {
    loggy.info('onLoginWithFacebookPressed()');
    await signInWithFacebook();
  }

  @override
  Widget build(BuildContext context) => RegisterView(controller: this);
}
