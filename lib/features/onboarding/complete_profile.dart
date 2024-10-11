import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class CompleteProfilePage extends StatefulWidget {
  static const String routeName = "/completeprofile";
  final SignupRequest? request;

  const CompleteProfilePage({Key? key, this.request}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  late AuthVM model;

  @override
  Widget build(BuildContext context) {
    var genderList = ["Male", "Female"];
    return ViewModelBuilder<AuthVM>.reactive(
        viewModelBuilder: () => AuthVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.signupRequest = widget.request;
          model.context = context;
          model.init(context);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold(
              showAppBar: true,
              includeAppBarBackButton: true,
              title: "",
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: const Text(
                            "Complete Your Profile",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: CustomColors.blackPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ).padding(bottom: 8, top: 30),
                        ),
                        Center(
                          child: Text(
                            "Your personal information is visible to only you. No one else can see it.",
                            style: Theme.of(context).textTheme.bodyMedium!,
                            textAlign: TextAlign.center,
                          ),
                        ).padding(bottom: 24),
                        Center(
                            child: SizedBox(
                                width: 64,
                                height: 64,
                                child: Image.asset(
                                  AssetUtil.editAvatar,
                                  scale: 1.5,
                                ))).padding(bottom: 24),
                      ],
                    ),
                    Form(
                      key: model.completeFormKey,
                      onChanged: model.onCompleteFormKeyChanged,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          CustomTextFields(
                            controller: model.fullNameController,
                            keyboardType: TextInputType.name,
                            label: model.userType?.name == "business" ?  "Company Name" : "Full Name",
                            showLabel: true,
                            labelText: model.userType?.name == "business" ? "Enter your company name" : "Enter your full name",
                            formatter: InputFormatter.stringOnly,
                            autocorrect: false,
                            //validate: (value) => ValidationUtil.validateLastName(value),
                            onSave: (value) =>
                                model.fullNameController.text = value,
                          ).padding(bottom: 20),
                          PhoneTextField(
                            hideCountryCode: false,
                            controller: model.phoneNumberController,
                            label: "Phone Number",
                            labelText: "Enter your phone number",
                            showLabel: true,
                            // validate: (value) => ValidationUtil.validatePhoneNumber(value),
                            onSave: (value) =>
                                model.phoneNumberController.text = value ?? "",
                          ).padding(bottom: 20),
                          CustomTextFields(
                            controller: model.addressController,
                            keyboardType: TextInputType.name,
                            label: "Address",
                            showLabel: true,
                            labelText: "Enter your current address",
                            formatter: InputFormatter.stringOnly,
                            autocorrect: false,
                            //validate: (value) => ValidationUtil.validateLastName(value),
                            onSave: (value) =>
                                model.fullNameController.text = value,
                          ).padding(bottom: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ).padding(bottom: 6),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(CupertinoIcons.person, size: 18)
                                          .padding(left: 4),
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(left: 27),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color: CustomColors.limcardFaded)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color: CustomColors.limcardFaded)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color: CustomColors.limcardFaded)),
                                ),
                                style: const TextStyle(color: CustomColors.blackPrimary),
                                icon:
                                    const Icon(CupertinoIcons.chevron_down, size: 18)
                                        .padding(right: 16),
                                hint: const Text("Gender",
                                    style: TextStyle(
                                        color: CustomColors.smallTextGrey,
                                        fontSize: 14)),
                                borderRadius: BorderRadius.circular(30),
                                items: genderList
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(e,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400, color: CustomColors.blackPrimary)),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) =>
                                    ValidationUtil.validateInput(
                                        value, "Gender"),
                                onSaved: (String? value) =>
                                    model.gender = value?.toUpperCase(),
                                onChanged: (value) {
                                  if (value != null) {
                                    model.setGender(value);
                                  }
                                },
                              ).padding(bottom: 20),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: !model.isButtonEnabled
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                   // model.formKey.currentState!.save();

                                    model.goToHome();
                                  },
                            child: const Text("Complete Profile"),
                          ).paddingBottom(16),

                          GestureDetector(
                            onTap: (){
                              model.goToHome();
                            },
                            child: const Center(child: Text(
                              "Complete later",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.limcadPrimary,
                                  fontWeight: FontWeight.w500),
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 16),
              ),
            ));
  }
}
