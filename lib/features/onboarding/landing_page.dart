import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/onboarding/widgets/slider_layout_view.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = "/landingPage";

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
    child: SliderLayoutView(),
  );
}