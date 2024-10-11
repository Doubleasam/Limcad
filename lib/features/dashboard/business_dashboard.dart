import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/dashboard/widgets/services_widget.dart';
import 'package:limcad/features/laundry/components/ServiceDetail/ServicesComponent.dart';
import 'package:limcad/features/laundry/laundry_detail.dart';
import 'package:limcad/resources/models/profile.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BusinessDashboard extends StatefulWidget {
  static String tag = '/BusinessDashboard';

  @override
  BusinessDashboardState createState() => BusinessDashboardState();
}

class BusinessDashboardState extends State<BusinessDashboard> {
  ProfileResponse? profileResponse = ProfileResponse();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: false,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100,
              floating: true,
              toolbarHeight: 120,
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              backgroundColor: CustomColors.kWhite,
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: ListTile(
                      leading: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          width: 40,
                          height: 40,
                          child: placeHolderWidget(
                              height: 40, width: 40, radius: 20)),
                      title: Text('Welcome Back,',
                          style: primaryTextStyle(
                              size: 16, weight: FontWeight.w400)),
                      subtitle: Text(profileResponse?.name ?? '',
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w600)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.backgroundGrey),
                        child: const Center(
                            child: Icon(
                          Icons.notifications,
                          color: black,
                          size: 24,
                        ))),
                  )
                ],
              ).padding(top: 40, right: 16),
            )
          ];
        },
        body: Container(
          color: white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      const BoxDecoration(color: CustomColors.backgroundColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Incoming orders',
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
                      ).paddingOnly(left: 16, right: 16, top: 40, bottom: 16),
                      HorizontalList(
                        itemCount: 5,
                        spacing: 16,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 73,
                            width: 235,
                            decoration: boxDecorationRoundedWithShadow(
                              18,
                              backgroundColor: white,
                            ),
                            child: ListTile(
                              horizontalTitleGap: 8,
                              leading: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  width: 45,
                                  height: 45,
                                  child: placeHolderWidget(
                                      height: 45, width: 45, radius: 22.5)),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 122,
                                        child: Text('Funsho Adeolu',
                                            overflow: TextOverflow.ellipsis,
                                            style: primaryTextStyle(
                                                size: 18,
                                                weight: FontWeight.w400)),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.green,
                                                width: 1.3),
                                            shape: BoxShape.circle),
                                        width: 16,
                                        height: 16,
                                        child: Center(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle),
                                            width: 11,
                                            height: 11,
                                          ),
                                        ),
                                      )
                                    ],
                                  ).paddingBottom(10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 18.34,
                                      ),
                                      Text('4.5',
                                              style: primaryTextStyle(
                                                  size: 13,
                                                  weight: FontWeight.w400))
                                          .paddingTop(4),
                                      Text(' |',
                                              style: primaryTextStyle(
                                                  size: 13,
                                                  color: grey.withOpacity(0.5),
                                                  weight: FontWeight.w400))
                                          .paddingTop(4),
                                      Text('30+ Orders',
                                              style: primaryTextStyle(
                                                  size: 13,
                                                  weight: FontWeight.w400))
                                          .paddingTop(4),
                                    ],
                                  ),
                                ],
                              ).paddingTop(13),
                            ),
                          );
                        },
                      ).paddingBottom(32),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Current orders',
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
                      ).paddingOnly(left: 16, right: 16, top: 13, bottom: 16),
                      Container(
                        height: 270,
                        child: ListView.builder(
                          itemCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 91,
                              width: MediaQuery.of(context).size.width - 38,
                              decoration: boxDecorationRoundedWithShadow(
                                18,
                                backgroundColor: CustomColors.backgroundGrey,
                              ),
                              child: ListTile(
                                horizontalTitleGap: 8,
                                leading: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    width: 45,
                                    height: 45,
                                    child: placeHolderWidget(
                                        height: 45, width: 45, radius: 22.5)),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 122,
                                          child: Text(
                                              index.isEven
                                                  ? 'Alice Johnson'
                                                  : 'David Adelaja',
                                              overflow: TextOverflow.ellipsis,
                                              style: primaryTextStyle(
                                                  size: 18,
                                                  weight: FontWeight.w400)),
                                        ),
                                      ],
                                    ).paddingBottom(10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            index.isEven
                                                ? 'Paid'
                                                : 'Paid on delivery',
                                            style: primaryTextStyle(
                                                size: 12,
                                                color: index.isEven
                                                    ? Colors.green
                                                    : Colors.orange,
                                                weight: FontWeight.w400)),
                                        Text('Delivery: 13/05/24',
                                            style: primaryTextStyle(
                                                size: 16,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                weight: FontWeight.w400)),
                                      ],
                                    ),
                                  ],
                                ).paddingTop(13),
                              ),
                            ).paddingSymmetric(vertical: 18, horizontal: 16);
                          },
                        ).paddingBottom(32),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      const BoxDecoration(color: CustomColors.backgroundColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Analytics',
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
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                      HorizontalList(
                        itemCount: 5,
                        spacing: 16,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 154,
                            width: 186,
                            decoration: boxDecorationRoundedWithShadow(
                              10,
                              backgroundColor: white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: index.isEven
                                              ? Colors.green
                                              : CustomColors.clotheColor
                                                  .withOpacity(0.8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      width: 28,
                                      height: 28,
                                    ),
                                    8.width,
                                    Text(
                                        index.isEven
                                            ? "Total orders"
                                            : "Total deliveries",
                                        style: primaryTextStyle(
                                            size: 16,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            weight: FontWeight.w500))
                                  ],
                                ).paddingBottom(14),
                                Text("48.4k",
                                        style: primaryTextStyle(
                                            size: 32,
                                            color: Colors.black,
                                            weight: FontWeight.w600))
                                    .paddingBottom(22),
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green),
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: Icon(
                                          Icons.trending_up_outlined,
                                          color: white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    8.width,
                                    Text(
                                        index.isEven
                                            ? "Total orders"
                                            : "Total deliveries",
                                        style: primaryTextStyle(
                                            size: 16,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            weight: FontWeight.w500))
                                  ],
                                )
                              ],
                            ).padding(left: 22, top: 14),
                          );
                        },
                      ).paddingBottom(32),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Delivery history',
                                  style: primaryTextStyle(
                                      size: 24, weight: FontWeight.w500))
                              .expand(),
                          TextButton(
                              onPressed: () {
                                // LSOfferAllScreen().launch(context);
                              },
                              child: Text('View All',
                                  style: secondaryTextStyle(
                                      color: CustomColors.limcadPrimary)))
                        ],
                      ).paddingOnly(left: 16, right: 16, top: 13, bottom: 16),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: 4,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 91,
                              width: MediaQuery.of(context).size.width - 38,
                              decoration: boxDecorationRoundedWithShadow(
                                18,
                                backgroundColor: CustomColors.backgroundGrey,
                              ),
                              child: ListTile(
                                horizontalTitleGap: 8,
                                leading: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    width: 45,
                                    height: 45,
                                    child: placeHolderWidget(
                                        height: 45, width: 45, radius: 22.5)),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 122,
                                          child: Text(
                                              index.isEven
                                                  ? 'Alice Johnson'
                                                  : 'Samson Dapo',
                                              overflow: TextOverflow.ellipsis,
                                              style: primaryTextStyle(
                                                  size: 18,
                                                  weight: FontWeight.w400)),
                                        ),
                                        Text('See all',
                                            style: primaryTextStyle(
                                                size: 12,
                                                color:
                                                    CustomColors.limcadPrimary,
                                                weight: FontWeight.w400))
                                      ],
                                    ).paddingBottom(10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Delivery: Today, 03:30pm',
                                            style: primaryTextStyle(
                                                size: 16,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                weight: FontWeight.w400)),
                                      ],
                                    ),
                                  ],
                                ).paddingTop(13),
                              ),
                            ).paddingSymmetric(vertical: 18, horizontal: 16);
                          },
                        ).paddingBottom(32),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 23),
          ),
        ),
      ),
    );
  }

  getProfile() async {
    BasePreference basePreference = await BasePreference.getInstance();
    setState(() {
      profileResponse = basePreference.getProfileDetails();
    });
  }
}
