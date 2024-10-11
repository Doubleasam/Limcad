import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 14 : 10,
      width: isActive ? 14 : 10,
      decoration: BoxDecoration(
        color: isActive ? CustomColors.limcadPrimary : Colors.grey,
        border: isActive ?  Border.all(color: Color(0xff927DFF),width: 2.0,) : Border.all(color: Colors.transparent,width: 1,),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}