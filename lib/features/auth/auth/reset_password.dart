import 'package:flutter/material.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/password_input_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = "/resetPassword";
  final UserType? userType;

  const ResetPassword({super.key, required this.userType});
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late AuthVM model;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.userType = widget.userType;
        model.context = context;
        model.init(context, OnboardingPageType.resetPassword, widget.userType);
      },
      builder: (BuildContext context, model, child) => DefaultScaffold(
        showAppBar: true,
        includeAppBarBackButton: true,
        busy: model.loading,
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "Reset Password",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: CustomColors.blackPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ).padding(bottom: 8),
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: Text(
                   model.otpSent ? "Please enter the otp sent to your email address" : "Please enter your email address below to reset your password",
                    style: Theme.of(context).textTheme.bodyMedium!,
                    textAlign: TextAlign.center,
                  ).padding(bottom: 20, left: 16, right: 16),
                ),
              ),
              Form(
                key: model.formKey,
                onChanged: model.onFormKeyChanged,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    CustomTextFields(
                      controller: model.emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: "Email Address",
                      labelText: "Enter your email address",
                      showLabel: true,
                      autocorrect: false,
                      onSave: (value) => model.email = value,
                      validate: (value) => ValidationUtil.isValidEmail(value),
                    ).padding(bottom: 60).hideIf(model.otpSent),

                    Column(
                      children: [
                        BlockInputField(
                          textColor: CustomColors.primary0_5,
                          controller: model.otpController,
                          digitCount: 6,
                          // onSaved: (value) => otpValue = value,
                        ).padding(bottom: 24),

                        PasswordInputField(
                          controller: model.password,
                          labelText: "Create New Password",
                          keyboardType: TextInputType.text,
                          node: model.passwordFocusNode,
                          validate: (value) =>
                              ValidationUtil.validatePassword(value),
                          // onSave: (value) =>
                          // model.loginRequest.password = value,
                        ).padding(bottom: 10),
                        PasswordInputField(
                          controller: model.confirmPassword,
                          labelText: "Confirm New Password",
                          keyboardType: TextInputType.text,
                          node: model.confirmPasswordFocusNode,
                          validate: (value) =>
                              ValidationUtil.validateConfirmPassword(
                                  value, model.password.text),
                          // onSave: (value) =>
                          // model.loginRequest.password = value,
                        ).padding(bottom: 60),
                      ],
                    ).hideIf(!model.otpSent),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: !model.isButtonEnabled
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        model.formKey.currentState!.save();

                      model.otpSent ? model.changePassword() :  model.sendResetPasswordCode();
                      },
                child: const Text("Continue"),
              ).paddingBottom(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Remember password?"),
                  TextButton(
                      onPressed: () {
                        NavigationService.pushScreen(context,
                            screen:
                             LoginPage(theUsertype: widget.userType),
                            withNavBar: false);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: CustomColors.rpBlue),
                      )),
                ],
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 20),
      ),
    );
  }
}
