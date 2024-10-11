import 'package:flutter/material.dart';
import 'package:limcad/features/auth/auth/reset_password.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/password_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  final UserType? theUsertype;

  const LoginPage({Key? key, this.theUsertype}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthVM>.reactive(
        viewModelBuilder: () => AuthVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.userType = widget.theUsertype;
          model.init(context, OnboardingPageType.login, widget.theUsertype);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold(
              showAppBar: true,
              includeAppBarBackButton: false,
              overrideBackButton: () {
                model.exitApp(context);
              },
              title: model.title,
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Sign In",
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineMedium!.merge(
                                  const TextStyle(
                                      color: CustomColors.limcadPrimary),
                                ),
                      ).padding(bottom: 8, top: 30),
                    ),
                    Center(
                      child: Text(
                        "Let’s get started with your account",
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ).padding(bottom: 20),
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
                            showLabel: true,
                            autocorrect: false,
                            //validate: (value) => ValidationUtil.validateLastName(value),
                            onSave: (value) => model.email = value,
                          ).padding(bottom: 20),
                          PasswordInputField(
                            controller: model.password,
                            labelText: "Password",
                            keyboardType: TextInputType.text,
                            node: model.passwordFocusNode,
                          ).padding(bottom: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("forgot password? "),
                              TextButton(
                                  onPressed: () {
                                    NavigationService.pushScreen(context,
                                        screen:  ResetPassword(
                                          userType: widget.theUsertype,
                                        ),
                                        withNavBar: false);
                                  },
                                  child: const Text(
                                    'reset here',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: CustomColors.rpBlue),
                                  )),
                            ],
                          ).paddingSymmetric(horizontal: 16),
                          ElevatedButton(
                            onPressed: !model.isButtonEnabled
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    model.formKey.currentState!.save();
                                    final SignupRequest request =
                                        new SignupRequest();
                                    request.email = model.emailController.text;
                                    request.password = model.password.text;
                                    model.proceedLogin(
                                        widget.theUsertype, request);
                                  },
                            child: const Text("Sign In"),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 20),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account? "),
                        TextButton(
                            onPressed: null,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.rpBlue),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

// ... (Add dispose method to clean up controllers)
}
