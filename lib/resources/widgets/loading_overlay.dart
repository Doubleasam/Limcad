import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: width,
        color: Colors.black38.withOpacity(0.5),
        child: const Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  // child: Image.asset(
                  //   AssetUtil.loader,
                  //   height: 125.0,
                  //   width: 125.0,
                  // ),
                  child: CircularProgressIndicator(
                    color: CustomColors.limcadPrimary,
                  ),
                ))));
  }
}
