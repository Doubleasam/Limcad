//import 'dart:js';

import 'dart:io';

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:limcad/features/CourierAccount/Home/courier_home.dart';
import 'package:limcad/features/auth/auth/create_password.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/auth/reset_password.dart';
import 'package:limcad/features/auth/auth/signup.dart';
import 'package:limcad/features/auth/auth/signup_otp.dart';
import 'package:limcad/features/auth/auth/signup_payment_details.dart';
import 'package:limcad/features/onboarding/business_welcome_page.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/onboarding/landing_page.dart';
import 'package:limcad/features/onboarding/user_type.dart';

final Map<String, WidgetBuilder> routes = {
  SignupPage.routeName: (context) =>
      const SignupPage(theUsertype: UserType.personal),
  SignupOtpPage.routeName: (context) => const SignupOtpPage(
        from: "",
      ),
  CreatePassword.routeName: (context) => const CreatePassword(),
  LoginPage.routeName: (context) => const LoginPage(),
  LandingPage.routeName: (context) => LandingPage(),
  UserTypePage.routeName: (context) => UserTypePage(),
  GetStartedPage.routeName: (context) => const GetStartedPage(
        theUsertype: UserType.personal,
      ),
  ResetPassword.routeName: (context) =>
      const ResetPassword(userType: UserType.personal),
  CourierHomeScreen.routeName: (context) => CourierHomeScreen(),
  BusinessWelcomePage.routeName: (context) => const BusinessWelcomePage(
        userType: UserType.business,
      ),
};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static pushScreen(BuildContext context,
          {required Widget screen, bool withNavBar = true}) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

  static pushScreenWithRouteSettings(
    BuildContext context, {
    required RouteSettings settings,
    required Widget screen,
    bool withNavBar = true,
  }) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => screen, settings: settings));
}
