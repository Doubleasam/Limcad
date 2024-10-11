import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/features/onboarding/constants/constants.dart';
import 'package:limcad/features/onboarding/models/slider.dart';
import 'package:limcad/features/onboarding/user_type.dart';
import 'package:limcad/features/onboarding/widgets/slide_dots.dart';
import 'package:limcad/features/onboarding/widgets/slide_item.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final FocusNode _detectorFocusNode = FocusNode();
  final FocusNode _keyboardFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _detectorFocusNode.dispose();
    _keyboardFocusNode.dispose();

  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    if(_currentPage == 2){
      Future.delayed(Duration(seconds: 3), () {
        NavigationService.pushScreen(context,
            screen:  UserTypePage(),
            withNavBar: false
        );
      });

    }
  }



  void _handleKeyPress(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _navigateLeft();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _navigateRight();
      }
    }
  }

  void _navigateLeft() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _navigateRight() {
    if (_currentPage < sliderArrayList.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _detectorFocusNode,
      autofocus: true,
      child: RawKeyboardListener(
        focusNode: _keyboardFocusNode,
        onKey: _handleKeyPress,
        child: topSliderLayout(),
      ),
    );
  }

  Widget topSliderLayout() => Container(
    child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 100.0), // Adjust bottom
                child: Text(
                  Constants.SKIP,
                  style: TextStyle(
                    fontFamily: Constants.OPEN_SANS,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: CustomColors.limcadPrimary
                  ),
                ),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.limcadPrimary,
                       // border: Border.all(color: CustomColors.limcadPrimary, width: 1),
                      ),
                      child: Center(child: Icon(Icons.arrow_forward, size: 20, color: Colors.white, ),)
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                           border: Border.all(color: CustomColors.limcadPrimary, width: 1),
                        ),
                        child: Center(child: Icon(Icons.arrow_back, size: 20, color: CustomColors.limcadPrimary, ),)
                    ),
                  ),
                ).hideIf(_currentPage == 0),

                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < sliderArrayList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}