import 'dart:async';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/domain/services/register_service.dart';
import 'package:ecoparking_flutter/domain/state/register/verify_email_otp.dart';
import 'package:ecoparking_flutter/domain/usecase/register/verify_email_otp_interactor.dart';
import 'package:ecoparking_flutter/pages/verify_otp/model/register_types.dart';
import 'package:ecoparking_flutter/pages/verify_otp/verify_otp_view.dart';
import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  final RegisterTypes registerType;

  const VerifyOtp({
    super.key,
    required this.registerType,
  });

  @override
  VerifyOtpController createState() => VerifyOtpController();
}

class VerifyOtpController extends State<VerifyOtp> with ControllerLoggy {
  final VerifyEmailOtpInteractor _verifyEmailOtpInteractor =
      getIt.get<VerifyEmailOtpInteractor>();
  final RegisterService _registerService = getIt.get<RegisterService>();

  final ValueNotifier<VerifyEmailOtpState> verifyEmailNotifier = ValueNotifier(
    const VerifyEmailOtpInitial(),
  );

  int get numberOfFields => 6;

  StreamSubscription? _verifyOtpSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _verifyOtpSubscription?.cancel();
    super.dispose();
  }

  void onSubmitted(String value) {
    loggy.info('onCodeChanged(): $value');
    final userEmail = _registerService.user?.email;

    if (userEmail == null) {
      _handleUserEmailIsNull();
    } else {
      _verifyOtpSubscription =
          _verifyEmailOtpInteractor.execute(userEmail, value).listen(
                (result) => result.fold(
                  _handleVerifyOtpFailure,
                  _handleVerifyOtpSuccess,
                ),
              );
    }
  }

  void _handleVerifyOtpFailure(Failure failure) {
    loggy.error('onCodeChanged(): verify otp failure: $failure');

    if (failure is VerifyEmailOtpEmptyAuth) {
      verifyEmailNotifier.value = failure;
      _showVerifyOtpSFailureDialog(
        'Có lỗi xảy ra',
        'Vui lòng thử lại!',
      );
    } else if (failure is VerifyEmailOtpAuthFailure) {
      verifyEmailNotifier.value = failure;
      _showVerifyOtpSFailureDialog(
        'Có lỗi xảy ra',
        failure.exception.message,
      );
    } else {
      verifyEmailNotifier.value = const VerifyEmailOtpEmptyAuth();
      _showVerifyOtpSFailureDialog(
        'Có lỗi xảy ra',
        failure.toString(),
      );
    }
  }

  void _handleVerifyOtpSuccess(Success success) {
    loggy.info('onCodeChanged(): verify otp success: $success');

    if (success is VerifyEmailOtpInitial || success is VerifyEmailOtpLoading) {
      return;
    }

    if (success is VerifyEmailOtpSuccess) {
      verifyEmailNotifier.value = success;
      _showVerifyOtpSuccessDialog();
    } else {
      verifyEmailNotifier.value = const VerifyEmailOtpEmptyAuth();
      _showVerifyOtpSFailureDialog(
        'Có lỗi xảy ra',
        'Vui lòng thử lại!',
      );
    }
  }

  void _showVerifyOtpSFailureDialog(
    String title,
    String description,
  ) {
    loggy.info('_showVerifyOtpSuccessDialog()');

    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogError,
      title: title,
      description: description,
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Đăng ký',
            onPressed: () {
              NavigationUtils.navigateTo(
                context: context,
                path: AppPaths.register,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void _showVerifyOtpSuccessDialog() {
    loggy.info('_showVerifyOtpSuccessDialog()');

    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogSuccessful,
      title: 'Xác thực thành công!',
      description: 'Đã xác thực thành công',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Go to Login',
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

  void _handleUserEmailIsNull() {
    loggy.error('onCodeChanged(): user email is null');

    DialogUtils.show(
      context: context,
      svgImage: ImagePaths.imgDialogError,
      title: 'Có lỗi xảy ra',
      description: 'Vui lòng thử lại!',
      actions: (context) {
        return <Widget>[
          ActionButton(
            type: ActionButtonType.positive,
            label: 'Đăng ký',
            onPressed: () {
              NavigationUtils.navigateTo(
                context: context,
                path: AppPaths.register,
              );
              DialogUtils.hide(context);
            },
          ),
        ];
      },
    );
  }

  void onBackButtonPressed(BuildContext scaffoldContext) {
    loggy.info('onBackButtonPressed()');
    NavigationUtils.navigateTo(
      context: scaffoldContext,
      path: AppPaths.register,
    );
  }

  @override
  Widget build(BuildContext context) => VerifyOtpView(
        controller: this,
        registerType: widget.registerType,
      );
}
