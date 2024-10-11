import 'package:flutter/material.dart';
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/profile/model/profile_view_model.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/light_theme.dart';
import 'package:limcad/resources/widgets/upload_widget.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class GalleryWidget extends StatefulWidget {
  static String tag = '/GalleryWidget';

  final LaundryItem? laundry;
  final UserType? userType;

  const GalleryWidget({Key? key, this.laundry, this.userType}) : super(key: key);


  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.image, widget.laundry);
      },
      builder: (BuildContext context, model, Widget? child) {
        return SingleChildScrollView(
          child: Container(
            width: context.width(),
            child: Container(
              width: context.width() * 0.8,
              alignment: Alignment.center,
              child: Column(
                children: [
                  32.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Gallery ',
                                style: boldTextStyle(
                                    color: CustomColors.blackPrimary,
                                    size: 14,
                                    fontFamily: "Josefin Sans")),
                            TextSpan(
                              text: '(${model.imgList?.length})',
                              style: boldTextStyle(
                                  color: CustomColors.limcadPrimary,
                                  size: 14,
                                  fontFamily:
                                      "Josefin Sans"), // Change color here
                            ),
                          ],
                        ),
                      ),
                      Text('See All',
                          style: secondaryTextStyle(
                              color: CustomColors.limcadPrimary, size: 14))
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const SizedBox(
                  //       width: 130,
                  //       child: ElevatedButton(
                  //         onPressed: null,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Icon(Icons.upload_file),
                  //             Text("Delete"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 130,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           NavigationService.pushScreen(context,
                  //               screen: FileUploadScreen());
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Image.asset(
                  //               AssetUtil.vectorUpload,
                  //               width: 15,
                  //               height: 15,
                  //             ),
                  //             Text("Upload"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ).paddingSymmetric(vertical: 20).hideIf(locator<AuthenticationService>().profile?.id != widget.laundry?.id),
                  Container(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: GridView.builder(
                      itemCount: model.imgList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 16, // Spacing between columns
                        mainAxisSpacing: 16, // Spacing between rows
                        childAspectRatio:
                            1, // Aspect ratio of each grid item (square in this case)
                      ),
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            model.setSelectedIndex(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: commonCachedNetworkImage(
                                ViewUtil.replaceLocalhost(model.imgList[index].img)  ,
                                    height: 136,
                                    width: 136,
                                    fit: BoxFit.cover)
                                .cornerRadiusWithClipRRect(10),
                          ),
                        );
                      },
                    ),
                  ).paddingSymmetric(vertical: 20),
                ],
              ).padding(bottom: 8, left: 16, right: 16),
            ),
          ),
        );
      },
    );
  }
}

class GuideLinesModel {
  String? img;
  String? name;
  String? type;
  String? detail;

  GuideLinesModel({this.img, this.name, this.type, this.detail});
}
