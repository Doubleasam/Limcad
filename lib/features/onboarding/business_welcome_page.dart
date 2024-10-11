import 'package:flutter/material.dart';
import 'package:limcad/features/onboarding/constants/constants.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/bottom_home.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';

class BusinessWelcomePage extends StatefulWidget {
  static const String routeName = "/businessWelcome";
  final UserType userType;
  const BusinessWelcomePage({super.key, required this.userType});

  @override
  State<BusinessWelcomePage> createState() => _BusinessWelcomePageState();
}

class _BusinessWelcomePageState extends State<BusinessWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: businessBody()),
    );
  }

  Widget businessBody() => Container(
        child: Column(
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: [
                  TextSpan(
                    text: "Are you a ",
                    style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Laundry ",
                    style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: CustomColors.limcadPrimary,
                    ),
                  ),
                  TextSpan(
                    text: "or ",
                    style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "delivery ",
                    style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: CustomColors.limcadPrimary,
                    ),
                  ),
                  TextSpan(
                    text: "agent? ",
                    style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ).padding(top: 100, bottom: 72),
            ),
            laundryAgentBody().padding(bottom: 40),
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
            deliveryAccountBody().padding(top: 40)
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );

  Widget laundryAgentBody() => Container(
        child: Column(
          children: [
            Center(
                child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(
                      AssetUtil.washingMachineImage,
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
                      text: "Create an account to offer ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "laundry services ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "to your customers.",
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
                        const GetStartedPage(theUsertype: UserType.business),
                    withNavBar: false);
              },
              child: const Text("Laundry agent"),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );
  Widget deliveryAccountBody() => Container(
        child: Column(
          children: [
            Center(
                child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(
                      AssetUtil.bikeImage,
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
                      text: "Create an account to offer ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.kBlack),
                    ),
                    TextSpan(
                      text: "delivery services ",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 12.5,
                          color: CustomColors.limcadPrimary),
                    ),
                    TextSpan(
                      text: "to our customers.",
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
                    screen: const GetStartedPage(theUsertype: UserType.courier),
                    //const HomePage(UserType.courier),
                    withNavBar: false);
              },
              child: const Text("Delivery account"),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      );
}
