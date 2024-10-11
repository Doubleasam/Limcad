import 'package:flutter/material.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/select_clothe.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ServicesComponent extends StatefulWidget {
  static String tag = '/LSServicesComponent';

  final LaundryItem? laundry;
  final UserType? userType;

  const ServicesComponent({Key? key, this.laundry, this.userType}) : super(key: key);

  @override
  ServicesComponentState createState() =>
      ServicesComponentState();
}

class ServicesComponentState extends State<ServicesComponent> {
  List<ServiceModel> getTopServiceList() {
    return [
      ServiceModel(
        img: AssetUtil.washingMenuIcon,
        title: 'Washing',
        iconBack: CustomColors.washingColor,
        onTap: () {
          // Action to perform when item is tapped
          print('Service 1 tapped');
        },
      ),
      ServiceModel(
        img: AssetUtil.clotheMenuIcon,
        title: 'Drying',
        iconBack: CustomColors.clotheColor,
        onTap: () {
          // Action to perform when item is tapped
          print('Service 2 tapped');
        },
      ),
      ServiceModel(
        img: AssetUtil.ironMenuIcon,
        title: 'Iron',
        iconBack: CustomColors.ironColor,
        onTap: () {
          // Action to perform when item is tapped
          print('Service 2 tapped');
        },
      ),
      ServiceModel(
        img: AssetUtil.packageMenuIcon,
        title: 'Package',
        iconBack: CustomColors.packageColor,
        onTap: () {
          // Action to perform when item is tapped
          print('Service 2 tapped');
        },
      ),
      // Add more ServiceModel instances as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Services', style: boldTextStyle()),
            8.height,
            GridView.builder(
              itemCount: getTopServiceList().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16, // Spacing between columns
                mainAxisSpacing: 16, // Spacing between rows
                childAspectRatio:
                    3, // Aspect ratio of each grid item (square in this case)
              ),
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                ServiceModel data = getTopServiceList()[i];

                return GestureDetector(
                  onTap: () {
                    data.onTap;
                  },
                  child: Container(
                    width: 172,
                    height: 73,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: lightGray.withOpacity(0.5), // Border color
                        width: 1, // Border width
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: data.iconBack.withOpacity(0.5)),
                              child: Center(
                                  child: Image.asset(
                                data.img,
                                height: 30,
                                width: 25,
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          ],
        ).paddingSymmetric(horizontal: 16, vertical: 32));
  }
}

class ServiceModel {
  final String img;
  final String title;
  final Function onTap;
  final Color iconBack;

  ServiceModel(
      {required this.img,
      required this.title,
      required this.onTap,
      required this.iconBack});
}
