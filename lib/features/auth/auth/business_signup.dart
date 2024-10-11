import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/models/state_model.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/password_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class BusinessSignUpPage extends StatefulWidget {
  static const String routeName = "/businessSignUpPage";

  final UserType theUsertype;
  const BusinessSignUpPage({Key? key, required this.theUsertype})
      : super(key: key);

  @override
  State<BusinessSignUpPage> createState() => _BusinessSignUpPageState();
}

class _BusinessSignUpPageState extends State<BusinessSignUpPage> {
  late AuthVM model;
  bool _agreedToTerms = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          model.init(context, OnboardingPageType.signup, widget.theUsertype);
        });
      },
      builder: (context, viewModel, child) => DefaultScaffold(
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
                child: const Text(
                  "Create Account",
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
                    "Fill out your details before or register with your social account.",
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
                      controller: model.fullNameController,
                      keyboardType: TextInputType.name,
                      label: "Company Name",
                      showLabel: true,
                      labelText: "Enter your company name",
                      autocorrect: false,
                      //validate: (value) => ValidationUtil.validateLastName(value),
                      onSave: (value) => model.fullNameController.text = value,
                    ).padding(bottom: 20),
                    PhoneTextField(
                      hideCountryCode: false,
                      controller: model.phoneNumberController,
                      label: "Phone Number",
                      labelText: "Enter your phone number",
                      showLabel: true,
                      validate: (value) =>
                          ValidationUtil.validatePhoneNumber(value),
                      onSave: (value) =>
                          model.phoneNumberController.text = value ?? "",
                    ).padding(bottom: 20),
                    CustomTextFields(
                      controller: model.emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: "Email Address",
                      labelText: "Enter your email address",
                      showLabel: true,
                      autocorrect: false,
                      validate: (value) => ValidationUtil.isValidEmail(value),
                      onSave: (value) => model.email = value,
                    ).padding(bottom: 20),
                    PasswordInputField(
                      controller: model.password,
                      labelText: "Password",
                      keyboardType: TextInputType.text,
                      node: model.passwordFocusNode,
                      validate: (value) =>
                          ValidationUtil.validatePassword(value),
                    ).padding(bottom: 10),
                    SizedBox(height: 5),
                    const Row(
                      children: [
                        Text(
                          "Hint",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "Mini. of 8, alpha-numeric, and at least 1 special character: @#%&",
                            style: TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CheckboxTheme(
                          data: CheckboxThemeData(
                            side: BorderSide(color: CustomColors.neutral4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return const Color(0xff2980B9);
                              }
                              return CustomColors.backgroundColor;
                            }),
                          ),
                          child: Checkbox(
                            value: _agreedToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreedToTerms = value!;
                              });
                            },
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'I agree with ',
                            style: TextStyle(color: Colors.black, fontSize: 10),
                            children: [
                              TextSpan(
                                text: 'terms',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 10),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'conditions',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).paddingBottom(20),
                    ElevatedButton(
                      onPressed: !_allConditionsMet()
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              model.formKey.currentState!.save();

                              model.proceedToSecondPage();
                            },
                      child: const Text("Proceed"),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or sign up with',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(Icons.apple),
                        const SizedBox(width: 20),
                        _socialButton(Icons.g_translate),
                        SizedBox(width: 20),
                        _socialButton(Icons.facebook),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        TextButton(
                            onPressed: () {
                              NavigationService.pushScreen(context,
                                  screen: const LoginPage(
                                      theUsertype: UserType.business),
                                  withNavBar: false);
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.rpBlue),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 20),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon) {
    return InkWell(
      onTap: () {
        // Handle social sign up
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: Icon(icon),
      ),
    );
  }

  bool _allConditionsMet() {
    return model.formKey.currentState?.validate() == true &&
        _agreedToTerms &&
        model.fullNameController.text.isNotEmpty &&
        model.emailController.text.isNotEmpty &&
        model.password.text.isNotEmpty &&
        model.phoneNumberController.text.isNotEmpty &&
        ValidationUtil.isValidPassword(model.password.text);
  }
}
