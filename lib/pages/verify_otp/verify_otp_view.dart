import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/domain/state/register/verify_email_otp.dart';
import 'package:ecoparking_flutter/pages/verify_otp/model/register_types.dart';
import 'package:ecoparking_flutter/pages/verify_otp/verify_otp.dart';
import 'package:ecoparking_flutter/pages/verify_otp/verify_otp_view_styles.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyOtpView extends StatelessWidget {
  final VerifyOtpController controller;
  final RegisterTypes registerType;

  const VerifyOtpView({
    super.key,
    required this.controller,
    required this.registerType,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.registerVerify.getTitle(),
      onBackButtonPressed: controller.onBackButtonPressed,
      body: Padding(
        padding: VerifyOtpViewStyles.padding,
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: controller.verifyEmailNotifier,
            builder: (context, verifyEmailState, child) {
              if (verifyEmailState is VerifyEmailOtpLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (verifyEmailState is VerifyEmailOtpInitial) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        registerType.verifyMessage,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(
                        height: VerifyOtpViewStyles.messageSpacing,
                      ),
                      OtpTextField(
                        numberOfFields: controller.numberOfFields,
                        showFieldAsBox: true,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.tertiary,
                        focusedBorderColor:
                            Theme.of(context).colorScheme.primary,
                        borderColor: Colors.transparent,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        onSubmit: controller.onSubmitted,
                      ),
                    ],
                  ),
                );
              }

              return child!;
            },
            child: const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
