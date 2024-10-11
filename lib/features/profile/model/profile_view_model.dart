// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:limcad/features/auth/models/login_response.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_response.dart' as signupRes;
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/laundry/model/about_response.dart';
import 'package:limcad/features/laundry/services/laundry_service.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/profile/profile_details.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/models/profile.dart';
import 'package:limcad/resources/models/state_model.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';

enum ProfileOption { about, addAddress, fetchProfile, description }

enum BottomSheetOption { accountName, phoneNumber, emailAddress, dob, address }

class ProfileVM extends BaseVM {
  final apiService = locator<APIClient>();
  late BuildContext context;
  String title = "";
  final instructionController = TextEditingController();
  final addressController = TextEditingController();
  final addressNameController = TextEditingController();
  final profile = locator<AuthenticationService>().profile;
  final profileFirstNameController = TextEditingController();
  final profileLastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final completeFormKey = GlobalKey<FormState>();
  final bool isPreview = false;
  bool isButtonEnabled = false;
  AboutResponse? laundryAbout;
  ProfileOption? profileOption;
  Prediction? prediction;
  ProfileResponse? profileResponseRequest;
  signupRes.Address? address;
  List<StateResponse> states = [];
  List<LGAResponse> lgas = [];
  StateResponse? selectedState;
  LGAResponse? selectedLGA;
  ProfileResponse? profileResponse = ProfileResponse();
  User? user = User();
  String? role;
  UserType? _userType;

  init(BuildContext context, ProfileOption profileOption, UserType userType) {
    this.context = context;
    this.profileOption = profileOption;
    this.role = role;
    this._userType = userType;
    if (profileOption == ProfileOption.addAddress) {
      fetchState();
    }
    if (profileOption == ProfileOption.fetchProfile) {
      getProfile();
    }
  }

  getProfile() async {
    BasePreference basePreference = await BasePreference.getInstance();

    profileResponse = basePreference.getProfileDetails();
    user = basePreference.getLoginDetails();

    notifyListeners();
  }

  fetchState() async {
    final response = await locator<AuthenticationService>().getStates();
    // states.addAll(response.data?.toList() ?? []);
    notifyListeners();
  }

  Future<void> setStateValue(StateResponse value) async {
    selectedState = value;
    if (selectedState != null) {
      final response = await locator<AuthenticationService>()
          .getLGAs(selectedState?.stateId);
      Logger().i(response.data);
      if (response.data!.isNotEmpty) {
        lgas.addAll(response.data?.toList() ?? []);
        Logger().i(response.data);
      }
    }
    notifyListeners();
  }

  Future<void> setLGAValue(LGAResponse value) async {
    selectedLGA = value;
    notifyListeners();
  }

  void setAddress(Prediction predict) {
    prediction = predict;
    address?.name = addressNameController.text;
    address?.additionalInfo = predict.description;
    address?.lgaId = selectedLGA?.id?.lgaId;
    address?.lga = selectedLGA?.lgaName;
    address?.stateId = selectedState?.stateId;
    address?.userType = UserType.personal.name.toUpperCase();
    final lgaReference = signupRes.LgaReference();
    lgaReference.lgaName = selectedLGA?.lgaName;
    lgaReference.id = signupRes.Id(
        lgaId: selectedLGA?.id?.lgaId, stateId: selectedState?.stateId);
    lgaReference.state = signupRes.State(
        stateId: selectedState?.stateId, stateName: selectedState?.stateName);
    address?.lgaReference = lgaReference;
    address?.genericUserId = profile?.id;
    address?.latitude = num.tryParse(predict?.lat ?? "0.0");
    address?.longitude = num.tryParse(predict?.lng ?? "0.0");
    notifyListeners();
  }

  Future<void> updateUserAddress() async {
    try {
      final response = await locator<AuthenticationService>().changeAddress();

      Logger().i('Profile update status: ${response.status}');
      if (response.status == 200) {
        showUpdatedDialog(context, BottomSheetOption.address);
        reset();
        await locator<AuthenticationService>().getProfile();
        getProfile();
      } else {
        Logger().e('Profile update failed with status: ${response.status}');
        reset();
        showErrorDialog(context, 'Profile update failed. Please try again.');
      }
    } catch (e) {
      reset();

      showErrorDialog(
          context, 'An unexpected error occurred. Please try again.');
    }
  }

  void showUpdateNameModal(
      BuildContext context, BottomSheetOption bottomSheetOption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEDF8FF),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            reset();
                          },
                          constraints: const BoxConstraints.tightFor(
                              width: 30, height: 30),
                          padding: EdgeInsets.zero,
                        ),
                      )
                    ],
                  ).padding(bottom: 30, top: 20),
                  if (bottomSheetOption == BottomSheetOption.accountName)
                    Column(
                      children: [
                        CustomTextFieldsForProfile(
                          controller: profileFirstNameController,
                          keyboardType: TextInputType.name,

                          label: "First Name",
                          showLabel: true,
                          labelText: "",
                          autocorrect: false,
                          //validate: (value) => ValidationUtil.validateLastName(value),
                          onSave: (value) =>
                              profileFirstNameController.text = value,
                        ).padding(bottom: 20),
                        const SizedBox(height: 16),
                        CustomTextFieldsForProfile(
                          controller: profileLastNameController,
                          keyboardType: TextInputType.name,
                          label: "Last Name",
                          showLabel: true,
                          labelText: "",
                          autocorrect: false,
                          //validate: (value) => ValidationUtil.validateLastName(value),
                          onSave: (value) =>
                              profileLastNameController.text = value,
                        )
                            .padding(bottom: 40)
                            .hideIf(_userType == UserType.business),
                      ],
                    ),
                  if (bottomSheetOption == BottomSheetOption.phoneNumber)
                    Form(
                      key: formKey,
                      onChanged: onFormKeyChanged,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: CustomTextFieldsForProfile(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        label: "Phone number",
                        showLabel: true,
                        labelText: "",
                        autocorrect: false,
                        //validate: (value) => ValidationUtil.validateLastName(value),
                        onSave: (value) => phoneNumberController.text = value,
                      ).padding(bottom: 30),
                    ),
                  if (bottomSheetOption == BottomSheetOption.emailAddress)
                    Form(
                      key: formKey,
                      onChanged: onFormKeyChanged,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: CustomTextFieldsForProfile(
                        controller: emailAddressController,
                        keyboardType: TextInputType.phone,
                        label: "Email address",
                        showLabel: true,
                        labelText: "",
                        autocorrect: false,
                        validate: (value) => ValidationUtil.isValidEmail(value),
                        //validate: (value) => ValidationUtil.validateLastName(value),
                        onSave: (value) => emailAddressController.text = value,
                      ).padding(bottom: 30),
                    ),
                  ElevatedButton(
                    child: Text(
                        'Update ${bottomSheetButtonTitle(bottomSheetOption)}'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      changeProfile(
                        profileFirstNameController.text,
                        profileLastNameController.text,
                        emailAddressController.text,
                        phoneNumberController.text,
                        "",
                        bottomSheetOption,
                      );

                      // showUpdatedDialog(context, bottomSheetOption);
                    },
                  ).paddingBottom(30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> changeProfile(
    String? name,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? dob,
    BottomSheetOption? option,
  ) async {
    final authService = locator<AuthenticationService>();
    final fullName = '${name ?? ''} ${lastName ?? ''}';
    final phone = phoneNumber ?? '';
    final userEmail = email ?? '';
    try {
      final response = _userType == UserType.personal
          ? await authService.changeProfile(fullName, phone, userEmail)
          : await authService.updateOrganization(fullName, phone, userEmail);

      Logger().i('Profile update status: ${response.status}');
      if (response.status == 200) {
        showUpdatedDialog(context, option!);
        reset();
        await locator<AuthenticationService>().getProfile();
        getProfile();
      } else {
        Logger().e('Profile update failed with status: ${response.status}');
        reset();
        showErrorDialog(context, 'Profile update failed. Please try again.');
      }
    } catch (e) {
      reset();

      showErrorDialog(
          context, 'An unexpected error occurred. Please try again.');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void reset() {
    profileFirstNameController.text = "";
    profileLastNameController.text = "";
    emailAddressController.text = "";
    phoneNumberController.text = "";
    notifyListeners();
  }

  void showUpdatedDialog(BuildContext context, BottomSheetOption option) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            content: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetUtil.successCheck,
                    width: 60,
                    height: 60,
                  ),
                  // const Icon(
                  //   Icons.check_circle,
                  //   color: Colors.green,
                  //   size: 60,
                  // ),
                  SizedBox(height: 20),
                  Text(
                    '${capitalizeFirstLetter(bottomSheetButtonTitle(option))} updated',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your ${bottomSheetButtonTitle(option)} has been successfully updated',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  onFormKeyChanged() {
    isButtonEnabled = formKey.currentState!.validate();
    notifyListeners();
  }

  String bottomSheetButtonTitle(BottomSheetOption option) {
    switch (option) {
      case BottomSheetOption.accountName:
        return "account name";
      case BottomSheetOption.phoneNumber:
        return "phone number";
      case BottomSheetOption.emailAddress:
        return "email address";
      case BottomSheetOption.dob:
        return "date of birth";
      case BottomSheetOption.address:
        return "Address Added";
    }
  }
}

class CustomTextFieldsForProfile extends StatefulWidget {
  final Color iconColor;
  final String? icon;
  final bool iconPresent;
  final TextEditingController? controller;
  final String? labelText;
  final String? label;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final int? inputLimit;
  final InputFormatter? formatter;
  final bool autocorrect;
  final Function? validate;
  final Function? onSave;
  final Function? onchange;
  final Function? onTap;
  final Function? onEditingComplete;
  final FocusNode? node;
  final bool showSuffixBusy;
  final bool readOnly;
  final bool showLabel;
  final int? maxLines;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final int? maxText;
  final Function(String)? onFieldSubmitted;
  final bool disabled;
  final Widget? suffixWidget;
  final TextInputAction? textInputAction;

  const CustomTextFieldsForProfile({
    Key? key,
    this.iconColor = CustomColors.limcadPrimary,
    this.controller,
    this.labelText = "",
    this.label,
    this.keyboardType,
    this.textCapitalization,
    this.inputLimit,
    this.formatter,
    this.autocorrect = false,
    this.validate,
    this.onSave,
    this.onchange,
    this.onTap,
    this.onEditingComplete,
    this.node,
    this.showSuffixBusy = false,
    this.readOnly = false,
    this.showLabel = false,
    this.maxLines,
    this.iconPresent = false,
    this.icon,
    this.hintText = "",
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onFieldSubmitted,
    this.maxText,
    this.disabled = false,
    this.suffixWidget,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextFieldsForProfile> createState() =>
      _CustomTextFieldsForProfileState();
}

class _CustomTextFieldsForProfileState
    extends State<CustomTextFieldsForProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: Theme.of(context).textTheme.bodyMedium!,
        ).padding(bottom: 6).hideIf(!widget.showLabel),
        TextFormField(
          decoration: InputDecoration(
              fillColor: widget.controller?.text.isEmpty == true
                  ? Color(0xffF6F6F6)
                  : Color(0xffF6F6F6),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: EdgeInsets.only(left: 27),
              prefixText: widget.iconPresent ? "|     " : "",
              prefixStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColors.appBlue,
              ),
              prefixIcon: widget.iconPresent
                  ? Transform.scale(
                      scale: 0.5,
                      child: ImageIcon(
                        AssetImage(
                          widget.icon!,
                        ),
                        size: 10,
                        color: widget.iconColor,
                      ),
                    )
                  : const SizedBox(),
              suffix: widget.suffixWidget,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              labelText: widget.labelText,
              suffixIcon: const CupertinoActivityIndicator()
                  .hideIf(!widget.showSuffixBusy)),
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.black),
          controller: widget.controller,
          readOnly: widget.readOnly,
          autocorrect: widget.autocorrect,
          focusNode: widget.node,
          maxLength: widget.maxText,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: widget.autovalidateMode,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization ??
              (widget.keyboardType != TextInputType.emailAddress
                  ? TextCapitalization.sentences
                  : TextCapitalization.none),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.inputLimit),
            if (widget.formatter == InputFormatter.stringOnly)
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-]")),
            if (widget.formatter == InputFormatter.digitOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            if (widget.formatter == InputFormatter.alphaNumericOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          validator: (value) =>
              widget.validate != null ? widget.validate!(value) : null,
          onSaved: (value) =>
              widget.onSave != null ? widget.onSave!(value) : null,
          onChanged: (value) =>
              widget.onchange != null ? widget.onchange!(value) : null,
          onTap: () => widget.onTap != null ? widget.onTap!() : null,
          onEditingComplete: () => widget.onEditingComplete != null
              ? widget.onEditingComplete!()
              : null,
        ),
      ],
    );
  }
}
