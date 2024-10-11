import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:limcad/features/auth/auth/business_signup.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/auth/signup.dart';
import 'package:limcad/features/onboarding/constants/constants.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';

enum UserType { personal, business, courier }

class GetStartedPage extends StatefulWidget {
  static const String routeName = "/getStarted";
  final UserType theUsertype;

  const GetStartedPage({Key? key, required this.theUsertype}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: getStartedBody()),
    );
  }

  Widget getStartedBody() => Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        widget.theUsertype == UserType.personal
                            ? AssetUtil.individualAccountBanner
                            : (widget.theUsertype == UserType.business
                                ? AssetUtil.businessAccountBanner
                                : AssetUtil.courierAccountBanner),
                      ))),
            ),
            personalBody()
                .padding(bottom: 40, top: 40)
                .hideIf(widget.theUsertype != UserType.personal),
            businessBody()
                .padding(top: 40)
                .hideIf(widget.theUsertype != UserType.business),
            deliveryBody()
                .padding(top: 40)
                .hideIf(widget.theUsertype != UserType.courier),
          ],
        ),
      );

  Widget personalBody() => Container(
        child: Column(
          children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Explore a wide range of ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "laundry services  ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "near you.",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                  ],
                ),
              ),
            )).padding(bottom: 8),
            const Text(
              "Browse through listings, read reviews, and compare prices to find the perfect match for your needs.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: Constants.OPEN_SANS,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CustomColors.kBlack),
            ).padding(bottom: 48),
            ElevatedButton(
              onPressed: () {
                NavigationService.pushScreen(context,
                    screen: const SignupPage(theUsertype: UserType.personal),
                    withNavBar: false);
              },
              child: const Text("Get Started"),
            ).padding(bottom: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                    onPressed: () {
                      NavigationService.pushScreen(context,
                          screen:
                              const LoginPage(theUsertype: UserType.personal),
                          withNavBar: false);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: CustomColors.rpBlue),
                    )),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  Widget businessBody() => Container(
        child: Column(
          children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Join our ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "laundry service  ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "network.",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                  ],
                ),
              ),
            )).padding(bottom: 8),
            const Text(
              "Grow your laundry business by connecting with clients looking for professional services.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: Constants.OPEN_SANS,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CustomColors.kBlack),
            ).padding(bottom: 48),
            ElevatedButton(
              onPressed: () {
                NavigationService.pushScreen(context,
                    screen: const BusinessSignUpPage(
                        theUsertype: UserType.business),
                    withNavBar: false);
              },
              child: const Text("Get Started"),
            ).padding(bottom: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                    onPressed: () {
                      NavigationService.pushScreen(context,
                          screen: const LoginPage(
                            theUsertype: UserType.business,
                          ),
                          withNavBar: false);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: CustomColors.rpBlue),
                    )),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  Widget deliveryBody() => Container(
        child: Column(
          children: [
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Join our ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "platform  ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "to reach goals.",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: CustomColors.kBlack),
                    ),
                  ],
                ),
              ),
            )).padding(bottom: 8),
            const Text(
              "Expand your delivery services – sign up now for endless opportunities!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: Constants.OPEN_SANS,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CustomColors.kBlack),
            ).padding(bottom: 48),
            ElevatedButton(
              onPressed: () {
                NavigationService.pushScreen(context,
                    screen: const SignupPage(theUsertype: UserType.courier),
                    withNavBar: false);
              },
              child: const Text("Get Started"),
            ).padding(bottom: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                    onPressed: () {
                      NavigationService.pushScreen(context,
                          screen: const LoginPage(
                            theUsertype: UserType.courier,
                          ),
                          withNavBar: false);
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: CustomColors.rpBlue),
                    )),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );
}
