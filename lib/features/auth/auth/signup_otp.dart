import 'package:flutter/material.dart';
import 'package:limcad/features/auth/models/business_onboarding_request.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:stacked/stacked.dart';

class SignupOtpPage extends StatefulWidget {
  static const String routeName = "/signupotp";
  final SignupRequest? request;
  final UserType? userType;
  final BusinessOnboardingRequest? businessRequest;
  final String from;
  const SignupOtpPage(
      {Key? key,
      this.request,
      this.userType,
      required this.from,
      this.businessRequest})
      : super(key: key);

  @override
  State<SignupOtpPage> createState() => _SignupOtpPageState();
}

class _SignupOtpPageState extends State<SignupOtpPage> {
  late AuthVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthVM>.reactive(
        viewModelBuilder: () => AuthVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.signupRequest = widget.request;
          model.userType = widget.userType;
          model.context = context;
          model.init(context, OnboardingPageType.signupOtp, widget.userType);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold(
              showAppBar: true,
              includeAppBarBackButton: true,
              title: model.title,
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    otpForm().hideIf(model.verified),
                    otpFeedback().hideIf(!model.verified)
                  ],
                ),
              ),
            ));
  }

  Widget otpForm() {
    return Column(
      children: [
        Center(
          child: Text(
            "Verify Email Address",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium!.merge(
                  const TextStyle(color: CustomColors.limcadPrimary),
                ),
          ).padding(bottom: 8, top: 30),
        ),
        Center(
          child: Text(
            "Please check your email and paste the OTP code we just sent to you in the boxes below:",
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
          ).padding(bottom: 20),
        ),
        Form(
          key: model.formKey,
          onChanged: model.onFormKeyChanged,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              BlockInputField(
                textColor: CustomColors.primary0_5,
                controller: model.otpController,
                digitCount: 6,
                // onSaved: (value) => otpValue = value,
              ).padding(bottom: 24),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn’t receive any OTP code? "),
                  TextButton(
                      onPressed: null,
                      child: Text(
                        'Resend code',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: CustomColors.limcadPrimary),
                      )),
                ],
              ).padding(bottom: 24),
              ElevatedButton(
                onPressed: !model.isButtonEnabled
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        model.formKey.currentState!.save();

                        model.proceedVerifyOTP();
                      },
                child: const Text("Verify OTP"),
              )
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 20),
        ),
      ],
    ).paddingSymmetric(
      horizontal: 24,
    );
  }

  Widget otpFeedback() {
    return Column(
      children: [
        Center(
          child: Image.asset(AssetUtil.otpEmailVerified, scale: 2.0),
        ),
        Center(
          child: Text(
            "Email Verified",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium!.merge(
                  const TextStyle(color: CustomColors.limcadPrimary),
                ),
          ).padding(bottom: 8, top: 30),
        ),
        Center(
          child: Text(
            "Your account has been successfully verified",
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
          ).padding(bottom: 20),
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: !model.isButtonEnabled
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      // model.formKey.currentState!.save();

                      model.proceedFromVerifyOTP();
                    },
              child: const Text("Continue"),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 20),
      ],
    ).paddingSymmetric(
      horizontal: 24,
    );
  }
}
