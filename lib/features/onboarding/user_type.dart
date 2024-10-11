import 'package:flutter/material.dart';
import 'package:limcad/features/onboarding/business_welcome_page.dart';
import 'package:limcad/features/onboarding/constants/constants.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/bottom_home.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';

class UserTypePage extends StatefulWidget {
  static const String routeName = "/userTypePage";

  @override
  State<StatefulWidget> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      showAppBar: false,
      includeAppBarBackButton: false,
      title: "",
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: onBordingBody()),
    );
  }

  Widget onBordingBody() => Container(
        child: Column(
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Choose the option that ",
                      style: TextStyle(
                        fontFamily: Constants.POPPINS,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "best suits ",
                      style: TextStyle(
                        fontFamily: Constants.POPPINS,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: CustomColors.limcadPrimary,
                      ),
                    ),
                    TextSpan(
                      text: "you",
                      style: TextStyle(
                        fontFamily: Constants.POPPINS,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ).padding(top: 100, bottom: 72),
            ),
            personalBody().padding(bottom: 40),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(
                  fontFamily: Constants.POPPINS,
                  fontWeight: FontWeight.w400,
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
            ),
            businessBody().padding(top: 40),
            //courierBody().padding(top: 40)
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  Widget personalBody() => Container(
        child: Column(
          children: [
            Center(
                child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(
                      AssetUtil.individualAccount,
                      scale: 1.5,
                    ))).padding(bottom: 16),
            Center(
                child: Container(
              width: 331,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Create your ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "personal account ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text:
                          "to enjoy seamless booking and tracking of laundry services",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                  ],
                ),
              ),
            )).padding(bottom: 16),
            ElevatedButton(
              onPressed: () {
                NavigationService.pushScreen(context,
                    screen: const GetStartedPage(
                      theUsertype: UserType.personal,
                    ),
                    withNavBar: false);
              },
              child: const Text("Personal account"),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  Widget businessBody() => Container(
        child: Column(
          children: [
            Center(
                child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(
                      AssetUtil.businessAccount,
                      scale: 2,
                    ))).padding(bottom: 16),
            Center(
                child: Container(
              width: 331,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Register your ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: " laundry or ride business ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "to connect with customers and expand your reach.",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                  ],
                ),
              ),
            )).padding(bottom: 16),
            ElevatedButton(
              onPressed: () {
                NavigationService.pushScreen(context,
                    screen:
                        const BusinessWelcomePage(userType: UserType.business),
                    withNavBar: false);
              },
              child: const Text("Business account"),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  // Widget courierBody() => Container(
  //       child: Column(
  //         children: [
  //           ElevatedButton(
  //             onPressed: () {
  //               NavigationService.pushScreen(context,
  //                   screen: const HomePage(UserType.courier),
  //                   withNavBar: false);
  //             },
  //             child: const Text("Courier account"),
  //           )
  //         ],
  //       ).paddingSymmetric(horizontal: 16, vertical: 16),
  //     );
}
