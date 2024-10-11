import 'package:flutter/material.dart';
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/dashboard/model/Dashboard_vm.dart';
import 'package:limcad/features/dashboard/widgets/services_widget.dart';
import 'package:limcad/features/laundry/components/ServiceDetail/ServicesComponent.dart';
import 'package:limcad/features/laundry/laundry_detail.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class Dashboard extends StatefulWidget {
  static String tag = '/Dashboard';

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  late DashboardVM model;

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

  List<OSDataModel> expiringSoon = getExpiringSoon();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardVM>.reactive(
        viewModelBuilder: () => DashboardVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.init(context, UserType.personal);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold2(
          showAppBar: false,
          busy: model.loading,
          body:
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 220,
                  floating: true,
                  toolbarHeight: 150,
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  backgroundColor: CustomColors.limcadPrimary,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: CustomColors.limcadPrimaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Icon(
                                  Icons.notifications,
                                  color: white,
                                  size: 24,
                                ))),
                      )
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Location',
                            style: primaryTextStyle(
                                color: lightGray,
                                size: 14,
                                weight: FontWeight.w500))
                            .paddingOnly(left: 16, right: 16, top: 8),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,
                                color: CustomColors.limcadYellow, size: 24),
                            SizedBox(
                              width: 160,
                              child: Text(locator<AuthenticationService>().profile?.address?[0].name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: primaryTextStyle(
                                      color: white,
                                      size: 18,
                                      fontFamily: "Josefin Sans",
                                      weight: FontWeight.w600)),
                            ),
                            Icon(Icons.expand_more_outlined,
                                color: CustomColors.limcadYellow, size: 24)
                                .padding(top: 4, left: 4)
                          ],
                        ).paddingAll(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  color: context.scaffoldBackgroundColor),
                              child: AppTextField(
                                textFieldType: TextFieldType.NAME,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  fillColor: white,
                                  hintText: 'Search ',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search, color: grey),
                                  contentPadding: EdgeInsets.only(
                                      left: 24.0, bottom: 8.0, top: 8.0, right: 24.0),
                                ),
                              ),
                            ),
                            Container(
                                width: 56,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Image.asset(
                                      AssetUtil.filterIcon,
                                      height: 24,
                                      width: 24,
                                      scale: 1,
                                    )))
                          ],
                        ).paddingSymmetric(horizontal: 16),

                      ],
                    ).paddingTop(60),
                  ),
                )
              ];
            },
            body: Container(
              color: CustomColors.limcardSecondary.withOpacity(0.55),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Services',
                            style: primaryTextStyle(
                                size: 24, weight: FontWeight.w500))
                            .expand(),
                        TextButton(
                            onPressed: () {
                              // LSOfferAllScreen().launch(context);
                            },
                            child: Text('See All',
                                style: secondaryTextStyle(
                                    color: CustomColors.limcadPrimary)))
                      ],
                    ).paddingOnly(left: 16, right: 16),
                    HorizontalList(
                      itemCount: getTopServiceList().length,
                      itemBuilder: (BuildContext context, int index) {
                        ServiceModel data = getTopServiceList()[index];

                        return Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(8),
                              decoration: boxDecorationRoundedWithShadow(40,
                                  backgroundColor: data.iconBack),
                              child: commonCacheImageWidget(
                                data.img.validate(),
                                35,
                                width: 35,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(data.title.validate(),
                                style: primaryTextStyle(
                                    size: 14, weight: FontWeight.w500)),
                          ],
                        ).onTap(() {
                          // NavigationService.pushScreen(context,
                          //     screen: LaundryDetailScreen(), withNavBar: true);
                        });
                      },
                    ).paddingSymmetric(horizontal: 16),
                    Row(
                      children: [
                        Text('Popular Services',
                            style: primaryTextStyle(
                                size: 24, weight: FontWeight.w500))
                            .expand(),
                        TextButton(
                            onPressed: () {
                              // LSOfferAllScreen().launch(context);
                            },
                            child: Text('See All',
                                style: secondaryTextStyle(
                                    color: CustomColors.limcadPrimary)))
                      ],
                    ).paddingOnly(left: 16, right: 16, top: 23, bottom: 8),

                    model.isShimmerLoading
                        ? buildShimmerLoader() // Shimmer loader
                        : GridView.builder(
                      itemCount: model.laundryOrganisations?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 16, // Spacing between columns
                        mainAxisSpacing: 16, // Spacing between rows
                        childAspectRatio: 0.9,
                      ),
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return ServiceItemWidget(model.laundryOrganisations![index]);
                      },
                    ),
                    //  LSSOfferPackageComponent(),
                  ],
                ).paddingSymmetric(vertical: 23),
              ),
            ),
          ),
        ));
  }

  Widget buildShimmerLoader() {
    return GridView.builder(
      itemCount: 4, // Show 4 shimmer items
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

}

class OSDataModel {
  String? image;
  String? profileImage;
  String? title;
  String? subtitle;
  String? details;
  String? categoryIcon;
  Color? color;
  double? price;
  int? srno;
  int? like;
  bool isSelected;

  OSDataModel({
    this.image,
    this.profileImage,
    this.title,
    this.subtitle,
    this.details,
    this.categoryIcon,
    this.color,
    this.price,
    this.srno,
    this.like,
    this.isSelected = false,
  });
}

//NFT Market Place home page list1 getCategories
List<OSDataModel> getCategories() {
  List<OSDataModel> list = [];

  list.add(OSDataModel(
      title: 'Art',
      image: image1,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Music',
      image: image2,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Domain Names',
      image: image3,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Virtual Worlds',
      image: image4,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Trading Card',
      image: image5,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Collectibles',
      image: image7,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Sports',
      image: image8,
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(OSDataModel(
      title: 'Utility',
      image: image9,
      categoryIcon: 'assets/images/placeholder.jpg'));

  return list;
}

const image1 = 'https://i.imgur.com/OB0y6MR.jpg'; //Landscape image
const image2 = 'https://i.imgur.com/CzXTtJV.jpg'; //Landscape image
const image3 =
    'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg'; //Landscape image
const image4 =
    'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg'; // Landscape image
const image5 = 'https://picsum.photos/id/237/200/300'; //potrait image
const image6 = 'https://picsum.photos/seed/picsum/200/300'; // potrait image
const image7 = 'https://picsum.photos/200/300';
const image8 = 'https://picsum.photos/200/300/?blur=2';
const image9 = 'https://picsum.photos/200/300?grayscale';
const image10 = 'https://picsum.photos/id/870/200/300?grayscale&blur=2';

List<OSDataModel> getExpiringSoon() {
  List<OSDataModel> list = [];

  list.add(OSDataModel(
      title: 'Impossible Blocks',
      subtitle: 'Impossible Blocks #654',
      price: 0.958,
      like: 0,
      image: image8,
      isSelected: false));
  list.add(OSDataModel(
      title: 'KnownOrigin',
      subtitle: 'Bavaria: For All The Dreamers',
      price: 4.7,
      like: 0,
      image: image10,
      isSelected: false));
  list.add(OSDataModel(
      title: 'Yat',
      subtitle: 'Movies',
      price: 0.456,
      like: 0,
      image: image9,
      isSelected: false));
  list.add(OSDataModel(
      title: 'L.O Community',
      subtitle: 'Lofi Originals #741',
      price: 0.456,
      like: 0,
      image: image7,
      isSelected: false));
  list.add(OSDataModel(
      title: 'Impossible Blocks',
      subtitle: 'Impossible Blocks #456',
      price: 0.752,
      like: 0,
      image: image3,
      isSelected: false));
  list.add(OSDataModel(
      title: "'MOAR' by Joan Cornella",
      subtitle: 'MOAR #3695',
      price: 2.52,
      like: 0,
      image: image2,
      isSelected: false));

  return list;
}
