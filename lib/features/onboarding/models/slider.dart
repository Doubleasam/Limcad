import 'package:flutter/cupertino.dart';
import 'package:limcad/features/onboarding/constants/constants.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderHeading2;
  final String? sliderHeading3;
  final String sliderSubHeading;

  Slider(
      {required this.sliderImageUrl,
        required this.sliderHeading,
        required this.sliderHeading2,
         this.sliderHeading3 = '',
        required this.sliderSubHeading});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/images/onboarding1.png',
      sliderHeading: Constants.SLIDER_HEADING_1,
      sliderHeading2: Constants.SLIDER_HEADING_12,
      sliderSubHeading: Constants.SLIDER_DESC1),
  Slider(
      sliderImageUrl: 'assets/images/onboarding2.png',
      sliderHeading: Constants.SLIDER_HEADING_2,
      sliderHeading2: Constants.SLIDER_HEADING_21,
      sliderHeading3: Constants.SLIDER_HEADING_22,
      sliderSubHeading: Constants.SLIDER_DESC2),
  Slider(
      sliderImageUrl: 'assets/images/onboarding3.png',
      sliderHeading: Constants.SLIDER_HEADING_3,
      sliderHeading2: Constants.SLIDER_HEADING_31,
      sliderHeading3: Constants.SLIDER_HEADING_32,
      sliderSubHeading: Constants.SLIDER_DESC3),
];