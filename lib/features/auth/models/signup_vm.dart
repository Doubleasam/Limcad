import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:limcad/features/auth/auth/business_signup.dart';
import 'package:limcad/features/auth/auth/business_signup_continuation.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/auth/signup.dart';
import 'package:limcad/features/auth/models/business_onboarding_request.dart';
import 'package:limcad/features/auth/models/login_response.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/auth/auth/create_password.dart';
import 'package:limcad/features/auth/auth/signup_otp.dart';
import 'package:limcad/features/auth/auth/signup_payment_details.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/onboarding/verify_id.dart';
import 'package:limcad/features/wallet/services/wallet_service.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/base_response.dart';
import 'package:limcad/resources/api/response_code.dart';
import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/bottom_home.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/models/change_profile_response.dart';
import 'package:limcad/resources/models/general_response.dart';
import 'package:limcad/resources/models/profile.dart';
import 'package:limcad/resources/models/state_model.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:logger/logger.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked_annotations.dart';

enum OnboardingPageType {
  signup,
  signupOtp,
  createPassword,
  login,
  resetPassword
}

enum IdType { document, nin }

class AuthVM extends BaseVM {
  final apiService = locator<APIClient>();
  late BuildContext context;
  SignupRequest? signupRequest = SignupRequest();
  BusinessOnboardingRequest? onboardingRequest = BusinessOnboardingRequest();
  final formKey = GlobalKey<FormState>();
  final completeFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final ninController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String title = "";
  String? email;
  bool isButtonEnabled = false;
  final otpController = TextEditingController();
  final password = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  final confirmPassword = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();
  final profile = locator<AuthenticationService>().profile;
  late CameraController controller = CameraController(
      CameraDescription(
          name: 'camera',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 180),
      ResolutionPreset.max);
  var genderList = ["Male", "Female"];

  bool verified = false;

  final taxNumber = TextEditingController();
  final routingNumber = TextEditingController();
  final accountNumber = TextEditingController();
  final accountName = TextEditingController();
  final bankNameController = TextEditingController();
  late BasePreference _preference;
  bool showDocumentView = false;
  bool documentVerified = false;
  bool showNinView = false;
  bool ninVerified = false;
  String? otpId;
  final addressController = TextEditingController();
  String? gender;
  UserType? userType;
  List<StateItems> states = [];
  List<LGAResponse> lgas = [];
  StateItems? selectedState;
  LGAResponse? selectedLGA;
  Prediction? prediction;

  bool otpSent = false;

  void init(BuildContext context,
      [OnboardingPageType? route, UserType? userT]) async {
    userType = userT;

    if (route == OnboardingPageType.signupOtp) {
      final response = await locator<AuthenticationService>()
          .requestOtp(signupRequest?.email, userType);
      Logger().i(response.data);
      //otpId = response.data?.otpId;
    }

    _preference = await BasePreference.getInstance();
  }

  void fetchState() async {
    try {
      final response = await locator<AuthenticationService>().getStates();
      Logger().i("Response received: $response");
      if (response.data?.items != null && response.data!.items!.isNotEmpty) {
        states = [];
        if (response.data?.items != null) {
          states.addAll(response.data!.items!.toList());
        }
        if (states.isNotEmpty) {
          selectedState = states[0];
          Logger().i("Selected state: $selectedState");
        }
      } else {
        Logger().w("No states returned from API");
        states = [];
        selectedState = null;
      }
      notifyListeners();
    } catch (e) {
      Logger().e("Error fetching states: $e");
    }
  }

  void _initializeController() async {
    controller.initialize();
  }

  void exitApp(BuildContext context) {}

  void proceed() {
    print('Email: ${emailController.text}');
    print('Full Name: ${fullNameController.text}');
    print('Phone Number: ${phoneNumberController.text}');
    print('Gender: ${gender?.toUpperCase()}');
    print('Latitude: ${prediction?.lat}');
    print('Longitude: ${prediction?.lng}');
    print('Address: ${addressController.text}');

    signupRequest?.email = emailController.text;
    signupRequest?.name = fullNameController.text;
    signupRequest?.phoneNumber = phoneNumberController.text;
    signupRequest?.gender = gender?.toUpperCase();

    signupRequest?.addressRequest ??= [];
    signupRequest?.addressRequest?.add(AddressRequest(
        additionalInfo: addressController.text,
        name: "Main Address",
        lgaRequest: LgaRequest(lgaId: selectedLGA?.id?.lgaId, stateId: selectedState?.stateId)));

    print('Signup Request: ${signupRequest?.toJson()}');

    NavigationService.pushScreen(
      context,
      screen: CreatePassword(request: signupRequest, userType: userType),
      withNavBar: false,
    );
  }

  void createAccount() async {
    onboardingRequest ??= BusinessOnboardingRequest(
        staffRequest: StaffRequest(addressRequest: []),
        organizationRequest: OrganizationRequest());
    onboardingRequest?.staffRequest ??= StaffRequest(addressRequest: []);
    onboardingRequest?.staffRequest!.addressRequest ??= [];
    onboardingRequest?.organizationRequest ??= OrganizationRequest();
    onboardingRequest?.staffRequest!.addressRequest?.clear();
    onboardingRequest?.staffRequest!.addressRequest?.add(AddressRequest(
        additionalInfo: addressController.text,
        name: "Address",
        lgaRequest: LgaRequest(lgaId: selectedLGA?.id?.lgaId, stateId: selectedState?.stateId)));
    onboardingRequest?.staffRequest?.gender = gender;
    onboardingRequest?.staffRequest?.roleEnums = ["ADMINISTRATOR"];
    onboardingRequest?.staffRequest?.userType = userType?.name.toString();
    onboardingRequest?.organizationRequest?.address = addressController.text;
    onboardingRequest?.organizationRequest?.name =
        onboardingRequest?.staffRequest?.name;
    onboardingRequest?.organizationRequest?.email =
        onboardingRequest?.staffRequest?.email;
    onboardingRequest?.organizationRequest?.location = addressController.text;
    onboardingRequest?.organizationRequest?.longitude = num.tryParse(prediction?.lng ?? "000");
    onboardingRequest?.organizationRequest?.latitude = num.tryParse(prediction?.lat ?? "000");
    onboardingRequest?.organizationRequest?.phoneNumber =
        onboardingRequest?.staffRequest?.phoneNumber;

    isLoading(true);
    final response = await locator<AuthenticationService>()
        .createBusinessAccount(onboardingRequest!);
    isLoading(false);

    if (response.status == 200 || response.status == 201) {
      if (context.mounted) {
        // NavigationService.pushScreen(context,
        //     screen: const HomePage("business"), withNavBar: false);
        signupRequest?.password = onboardingRequest?.staffRequest?.password;
        signupRequest?.email = onboardingRequest?.staffRequest?.email;
        print("Sign up request: ${signupRequest?.password}");
        print("Sign up request: ${signupRequest?.email}");
        proceedLogin(userType, signupRequest);
      } else {
        if (response.status != 200 || response.status != 201) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'An error has occurred',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        }
      }
    } else {}
  }

  void proceedToSecondPage() {
    onboardingRequest?.staffRequest ??= StaffRequest();

    onboardingRequest?.staffRequest?.email = emailController.text;
    onboardingRequest?.staffRequest?.name = fullNameController.text;
    onboardingRequest?.staffRequest?.password = password.text;
    onboardingRequest?.staffRequest?.phoneNumber = phoneNumberController.text;
    NavigationService.pushScreen(context,
        screen: BusinessSignUpSecondPage(
          theUsertype: userType!,
          businessRequest: onboardingRequest,
        ));
  }

  void proceedToVerifyEmail() async {
    onboardingRequest ??= BusinessOnboardingRequest();
    onboardingRequest?.staffRequest ??= StaffRequest();

    onboardingRequest?.staffRequest?.email = emailController.text;
    onboardingRequest?.staffRequest?.name = fullNameController.text;
    onboardingRequest?.staffRequest?.password = password.text;
    try {
      final response = await locator<AuthenticationService>()
          .requestOtp(onboardingRequest?.staffRequest?.email, userType);

      Logger().i(response.status);

      isLoading(false);

      if (response.status == 200 && context.mounted) {
        NavigationService.pushScreen(
          context,
          screen: SignupOtpPage(
            businessRequest: onboardingRequest,
            userType: userType,
            from: BusinessSignUpPage.routeName,
          ),
          withNavBar: true,
        );
      } else {
        print("Failed to request OTP or context not mounted.");
      }
    } catch (e) {
      print("Error during OTP request: $e");
      Logger().e('Error requesting OTP: $e');
    }
  }

  Future<void> sendResetPasswordCode() async {
    isLoading(true);
    final response = await locator<AuthenticationService>()
        .requestResetPasswordCode(userType, emailController.text);
    isLoading(false);

    if (response.status == 204) {
      otpSent = true;
      notifyListeners();
    }
  }

  Future<void> proceedVerifyOTP() async {
    isLoading(true);
    final response = await locator<AuthenticationService>()
        .validateOtp(signupRequest?.email, otpController.text, userType!.name);
    isLoading(false);
    if (response.status == ResponseCode.created ||
        response.status == ResponseCode.success) {
      if (response.data?.token != null) {
        _preference.saveToken(Tokens(
            token: response.data?.token,
            refreshToken: response.data?.refreshToken));
      }
      if (response.data?.user != null) {
        _preference.saveLoginDetails(response.data!.user!);
      }
      // ignore: use_build_context_synchronously
      ViewUtil.showDynamicDialogWithButton(
          barrierDismissible: false,
          context: context,
          titlePresent: false,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  AssetUtil.successCheck,
                  width: 64,
                  height: 64,
                ).padding(bottom: 24, top: 22),
              ),
              const Text(
                "Email Verified",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColors.kBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    height: 1.2),
              ).padding(bottom: 16),
              const Text(
                "You have successfully verified your email address",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColors.kBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.2),
              ).padding(bottom: 24)
            ],
          ),
          buttonText: "Continue",
          dialogAction1: () async {
            Navigator.pop(context);
            userType == UserType.personal || userType ==  UserType.courier
                ? _preference.saveLoginDetails(response.data!.user!)
                : _preference.saveBusinessLoginDetails(response.data!.user!);
            isLoading(true);
            final profileResponse = userType == UserType.personal || userType ==  UserType.courier
                ? await locator<AuthenticationService>().getProfile()
                : await locator<AuthenticationService>().getBusinessProfile();
            isLoading(false);

            if (profileResponse.status == ResponseCode.success &&
                profileResponse.data != null) {
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(userType)),
                    (Route<dynamic> route) => false);
                // NavigationService.pushScreen(context,
                //     screen: HomePage(userType), withNavBar: false);
              }
            }
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => VerifyIdPage(request: signupRequest)));
          });

      notifyListeners();
    }
  }

  onFormKeyChanged() {
    isButtonEnabled = formKey.currentState!.validate();
    notifyListeners();
  }

  onCompleteFormKeyChanged() {
    isButtonEnabled = completeFormKey.currentState!.validate();
    notifyListeners();
  }

  Future<void> proceedFromVerifyOTP() async {}

  Future<void> proceedPassword() async {
    signupRequest?.password = password.text;
    isLoading(true);
    final response =
        await locator<AuthenticationService>().signUp(signupRequest);

    if (response.status == 200 || response.status == 201) {
      if (response.data != null) {
        // _preference.saveProfile(response.data!.);
        Logger().i("response :${response.data}");
        final UserType userType =
            response.data!.userType == userTypeToString(UserType.personal)
                ? UserType.personal
                : UserType.business;
        print("userType: ${userTypeToString(UserType.personal)}");
        // ignore: use_build_context_synchronously
        NavigationService.pushScreen(context,
            screen: SignupOtpPage(
              request: signupRequest,
              userType: userType,
              from: SignupPage.routeName,
            ),
            withNavBar: true);
      }
    } else {
      if (response.status != 200 || response.status != 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'An error has occurred',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
      //ViewUtil.sh
    }
    isLoading(false);

    //  }
  }

  Future<void> proceedPasswordDelivery() async {
    signupRequest?.password = password.text;
    isLoading(true);
    final response =
        await locator<AuthenticationService>().signUp(signupRequest);

    if (response.status == 200 || response.status == 201) {
      if (response.data != null) {
        // _preference.saveProfile(response.data!.);
        Logger().i("response :${response.data}");
        // final UserType userType =
        //     response.data!.userType == userTypeToString(UserType.courier)
        //         ? UserType.courier
        //         : UserType.business;
        print("userType: ${userTypeToString(UserType.courier)}");
        // ignore: use_build_context_synchronously
        NavigationService.pushScreen(context,
            screen: SignupOtpPage(
              request: signupRequest,
              userType: UserType.courier,
              from: SignupPage.routeName,
            ),
            withNavBar: true);
      }
    } else {
      if (response.status != 200 || response.status != 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'An error has occurred',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
      //ViewUtil.sh
    }
    isLoading(false);

    //  }
  }

  String userTypeToString(UserType type) {
    switch (type) {
      case UserType.personal:
        return 'PERSONAL';
      case UserType.business:
        return 'BUSINESS';
      default:
        return '';
    }
  }

  Future<void> proceedLogin(UserType? userType, SignupRequest? request) async {
    try {
      if (request == null || userType == null) {
        throw Exception('Invalid signup request or user type');
      }

      isLoading(true);
      final response =
          await locator<AuthenticationService>().login(request, userType);

      if (response.status == ResponseCode.success || response.status == 201) {
        await _handleSuccessfulLogin(response.data, userType, request);
      } else if (response.status == ResponseCode.unauthorized) {
        if (context.mounted) {
          NavigationService.pushScreen(
            context,
            screen: SignupOtpPage(
              request: request,
              userType: userType,
              from: LoginPage.routeName,
            ),
            withNavBar: true,
          );
        }
      } else {
        ViewUtil.showSnackBar(response.message ?? "An error occurred", true);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> _handleSuccessfulLogin(
      LoginResponse? data, UserType userType, SignupRequest request) async {
    if (data?.token != null) {
      await _saveToken(data!);
    }

    if (data?.user != null) {
      await _saveUserDetails(data!.user!, userType);
      await _fetchAndNavigateToProfile(data!.user!, userType, request);
    }
  }

  Future<void> _saveToken(LoginResponse data) async {
    final tokenJson = {"token": data.token, "refreshToken": data.refreshToken};
    _preference.saveToken(Tokens.fromJson(tokenJson));
  }

  Future<void> _saveUserDetails(User user, UserType userType) async {
    if (userType == UserType.personal) {
      _preference.saveLoginDetails(user);
      final wallet = await locator<WalletService>().createUserWallet(user.id);
      if (wallet.data != null) {
        _preference.saveWalletDetails(wallet.data!);
      }
    } else {
      _preference.saveBusinessLoginDetails(user);
    }
  }

  Future<void> _fetchAndNavigateToProfile(User user, UserType userType, SignupRequest request) async {
    isLoading(true);
    try {
      final profileResponse = userType == UserType.personal
          ? await locator<AuthenticationService>().getProfile()
          : await locator<AuthenticationService>().getBusinessProfile();

      if (profileResponse.status == ResponseCode.success &&
          profileResponse.data != null) {
        setupFireBaseChat(user, request);
        print("the user userType: ${userType}");
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(userType)),
                  (Route<dynamic> route) => false);
        }
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> setupFireBaseChat(User user, SignupRequest request) async {
    try {
      // Reference to Firestore 'users' collection
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.id.toString());

      // Check if user already exists
      final userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        print("User already exists in Firestore with ID: ${user.id}");
        return; // Exit if user already exists
      }

      // Split the name into firstName and lastName
      List<String> nameParts = (user.name ?? "").split(" ");
      String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
      String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
      Map<String, dynamic>? metadata = user.toJson();

      // User does not exist, so create a new user in Firestore for Firebase Chat
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: firstName,
          id: user.id.toString(), // Use the provided user id
          metadata: metadata,
          imageUrl: 'https://i.pravatar.cc/300?u=${user.email}',
          lastName: lastName,
        ),
      );

      print("New user created in Firestore with ID: ${user.id}");

    } catch (e) {
      print("Error creating user in Firestore: $e");
    }
  }


  void setId(IdType idType) {
    if (idType == IdType.document) {
      showDocumentView = true;
      _initializeController();
      notifyListeners();
    } else if (idType == IdType.nin) {
      showNinView = true;
      notifyListeners();
    }
  }

  void documentVerify() {
    showDocumentView = false;
    documentVerified = true;
    notifyListeners();
  }

  void ninVerify() {
    showNinView = false;
    ninVerified = true;
    notifyListeners();
  }

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void goToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(userType)),
            (Route<dynamic> route) => false);
  }

   setStateValue(String value) async {
    selectedState = states.firstWhere((element) => element.stateName?.toLowerCase() == value.toLowerCase() );
    if (selectedState != null) {
      getStateID(selectedState?.stateId);
      isLoading(true);
      try {
        final response =
            await locator<AuthenticationService>().getLGAs(selectedState?.stateId);
        if (response.data != null && response.data!.isNotEmpty) {
          lgas.addAll(response.data!.toList());
        } else {
          lgas = [];
        }
      } catch (e) {
        Logger().e("Error fetching LGAs: $e");
        lgas = [];
      }

      isLoading(false);
      notifyListeners();
    } else {
      lgas = [];
      isLoading(false);
      notifyListeners();
    }
  }

  String? getStateID(String? name) {
    for (StateItems stateItem in states) {
      if (stateItem.stateName == name) {
        return stateItem.stateId;
      }
    }
    return null;
  }

  Future<void> setLGAValue(LGAResponse? value) async {
    selectedLGA = value;
    notifyListeners();
  }

  int? getLGAID(String? name) {
    for (LGAResponse item in lgas) {
      if (item.lgaName == name) {
        return item.id?.lgaId;
      }
    }
    return null;
  }

  void setAddress(Prediction predict) {
    prediction = predict;
    notifyListeners();
  }

  goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage(theUsertype: userType!);
    }));
  }

  changePassword() async {

    isLoading(true);
    final response = await locator<AuthenticationService>()
        .changePassword(emailController.text,  otpController.text, userType!.name, password.text);
    isLoading(false);
    if (response.status == ResponseCode.success ||
        response.status == ResponseCode.success04) {

      // ignore: use_build_context_synchronously
      ViewUtil.showDynamicDialogWithButton(
          barrierDismissible: false,
          context: context,
          titlePresent: false,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  AssetUtil.successCheck,
                  width: 64,
                  height: 64,
                ).padding(bottom: 24, top: 22),
              ),
              const Text(
                "Password Changed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColors.kBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    height: 1.2),
              ).padding(bottom: 16),
              const Text(
                "You have successfully changed your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColors.kBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.2),
              ).padding(bottom: 24)
            ],
          ),
          buttonText: "Login",
          dialogAction1: () async {
            Navigator.pop(context);
            NavigationService.pushScreen(context,
                screen:
                 LoginPage(theUsertype: userType),
                withNavBar: false);

          });

      notifyListeners();
    }else{
      ViewUtil.showSnackBar(response.message ?? "An error occurred", true);
    }
  }
}
