import 'package:flutter/material.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/password_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:stacked/stacked.dart';

class CreatePassword extends StatefulWidget {
  static const String routeName = "/createpassword";
  final SignupRequest? request;
  final UserType? userType;
  const CreatePassword({Key? key, this.request, this.userType})
      : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
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
          model.init(context, OnboardingPageType.createPassword);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold(
              showAppBar: true,
              includeAppBarBackButton: true,
              showAppBarWithStringTitle: true,
              title: "Create Password",
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Choose a strong password to protect your account",
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ).padding(bottom: 20),
                    ),
                    Form(
                      key: model.formKey,
                      onChanged: model.onFormKeyChanged,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          PasswordInputField(
                            controller: model.password,
                            labelText: "Create Password",
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
                          ).padding(bottom: 10),
                          ElevatedButton(
                            onPressed: !model.isButtonEnabled
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    model.formKey.currentState!.save();

                                    //model.proceedPassword();
                                    switch (widget.userType) {
                                      case UserType.personal:
                                        model.proceedPassword();
                                        break;
                                      case UserType.courier:
                                        model.proceedPasswordDelivery();
                                        break;

                                      default:
                                        print("unhandled user");
                                    }
                                  },
                            child: const Text("Done"),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 20),
                    ),
                  ],
                ),
              ),
            ));
  }
}
