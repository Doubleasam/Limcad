import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/features/dashboard/dashboard.dart';
import 'package:limcad/features/laundry/laundry_detail.dart';
import 'package:limcad/features/laundry/select_clothe.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/onboarding/landing_page.dart';
import 'package:limcad/features/onboarding/user_type.dart';
import 'package:limcad/firebase_options.dart';
import 'package:limcad/resources/bottom_home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:limcad/features/auth/auth/login.dart';
import 'package:limcad/features/auth/auth/signup.dart';
import 'package:limcad/features/auth/auth/signup_payment_details.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/widgets/light_theme.dart';

void doSetup({bool isPos = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  BasePreference preference = await BasePreference.getInstance();
  bool? loggedIn = preference.getIsRegistered();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MaterialApp(
        title: 'limcad App',
        theme: lightTheme(),
        home: Builder(
          builder: (BuildContext context) {
            return MyApp(loggedIn: loggedIn,);
          },
        ),
        routes: routes,
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then(
        (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
}

class MyApp extends StatefulWidget {
  final bool? loggedIn;

  const MyApp({Key? key, this.loggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
 // final connectivityStatus = InternetConnectivityService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [widget.loggedIn! ? const LoginPage() : UserTypePage()],
      ),
    );
  }

  @override
  void initState() {
    //initBackgroundTask();
    WidgetsBinding.instance.addObserver(this);
   // connectivityStatus.init(context: context);

    super.initState();
  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // connectivityStatus.dispose();
    super.dispose();
  }
}
