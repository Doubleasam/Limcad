import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:limcad/features/CourierAccount/Analytics/courier_analytics.dart';
import 'package:limcad/features/CourierAccount/Analytics/widget/earning_chart.dart';
import 'package:limcad/features/CourierAccount/Delivery/delivery.dart';
import 'package:limcad/features/CourierAccount/Home/courier_home.dart';
import 'package:limcad/features/analytics/analytics.dart';
import 'package:limcad/features/chat/chats_screen.dart';
import 'package:limcad/features/chat/room.dart';
import 'package:limcad/features/dashboard/business_dashboard.dart';
import 'package:limcad/features/dashboard/dashboard.dart';
import 'package:limcad/features/explore/explore.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/order/business_orders.dart';
import 'package:limcad/features/order/orders.dart';
import 'package:limcad/features/profile/profile.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/bottom_bar/bottom_bar.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  final UserType? userType;

  const HomePage(this.userType, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        duration: const Duration(seconds: 1),
        curve: Curves.decelerate,
        showIcon: false,
        width: MediaQuery.of(context).size.width,
        start: 4,
        end: 0,
        barAlignment: Alignment.bottomCenter,
        reverse: false,
        hideOnScroll: false,
        scrollOpposite: false,
        onBottomBarHidden: () {},
        onBottomBarShown: () {},
        body: (context, controller) => TabBarView(
              controller: tabController,
              dragStartBehavior: DragStartBehavior.down,
              physics: const BouncingScrollPhysics(),
              children: getPage(widget.userType!),
            ),
        child: TabBar(
            padding: EdgeInsets.zero,
            controller: tabController,
            labelPadding:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 5),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 0),
                insets: EdgeInsets.fromLTRB(16, 0, 16, 0)),
            tabs: [
              Container(
                height: 65,
                width: 65,
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              AssetUtil.homeIcon,
                              color: currentPage == 0
                                  ? CustomColors.limcadPrimary
                                  : CustomColors.blackPrimary,
                              fit: BoxFit.scaleDown,
                            ))).padding(bottom: 8, top: 16),
                    Text(
                      "Home",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .merge(TextStyle(
                            color: currentPage == 0
                                ? CustomColors.limcadPrimary
                                : CustomColors.blackPrimary,
                            fontFamily: "inter",
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 65,
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              widget.userType == UserType.courier
                                  ? AssetUtil.analyticsIcon
                                  : AssetUtil.exploreIcon,
                              color: currentPage == 1
                                  ? CustomColors.limcadPrimary
                                  : CustomColors.blackPrimary,
                              fit: BoxFit.scaleDown,
                            ))).padding(bottom: 8, top: 16),
                    Text(
                      widget.userType == UserType.business ||
                              widget.userType == UserType.courier
                          ? "Analytics"
                          : "Explore",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .merge(TextStyle(
                            color: currentPage == 1
                                ? CustomColors.limcadPrimary
                                : CustomColors.blackPrimary,
                            fontFamily: "inter",
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 65,
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              widget.userType == UserType.courier
                                  ? AssetUtil.deliveryIcon
                                  : AssetUtil.orderIcon,
                              color: currentPage == 2
                                  ? CustomColors.limcadPrimary
                                  : CustomColors.blackPrimary,
                              fit: BoxFit.scaleDown,
                            ))).padding(bottom: 8, top: 16),
                    Text(
                      widget.userType == UserType.courier
                          ? "Delivery"
                          : "Order",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .merge(TextStyle(
                            color: currentPage == 2
                                ? CustomColors.limcadPrimary
                                : CustomColors.blackPrimary,
                            fontFamily: "inter",
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 65,
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              AssetUtil.chatIcon,
                              color: currentPage == 3
                                  ? CustomColors.limcadPrimary
                                  : CustomColors.blackPrimary,
                              fit: BoxFit.scaleDown,
                            ))).padding(bottom: 8, top: 16),
                    Text(
                      "Chat",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .merge(TextStyle(
                            color: currentPage == 3
                                ? CustomColors.limcadPrimary
                                : CustomColors.blackPrimary,
                            fontFamily: "inter",
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 65,
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              AssetUtil.profileIcon,
                              color: currentPage == 4
                                  ? CustomColors.limcadPrimary
                                  : CustomColors.blackPrimary,
                              fit: BoxFit.scaleDown,
                            ))).padding(bottom: 8, top: 16),
                    Text(
                      "Profile",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .merge(TextStyle(
                            color: currentPage == 4
                                ? CustomColors.limcadPrimary
                                : CustomColors.blackPrimary,
                            fontFamily: "inter",
                          )),
                    )
                  ],
                ),
              ),
            ]));
  }

  String userTypeToString(UserType type) {
    switch (type) {
      case UserType.personal:
        return 'PERSONAL';
      case UserType.business:
        return 'BUSINESS';
      case UserType.courier:
        return 'COURIER';
      default:
        return '';
    }
  }

  List<Widget> getPage(UserType type) {
    switch (type) {
      case UserType.personal:
        return [
          Dashboard(),
          ExploreScreen(),
          OrdersPage(),
          ChatsScreen(),
          ProfilePage(userType: widget.userType!)
        ];
      case UserType.business:
        return [
          BusinessDashboard(),
          //AnalyticsPage(),
          BusinessOrdersPage(),
          ChatsScreen(),
          ProfilePage(userType: widget.userType!)
        ];
      case UserType.courier:
        return [
          CourierHomeScreen(),
          EarningsSummary(),
          DeliveryHistoryScreen(),
          EarningsChart(),
          CourierHomeScreen()
        ];
      default:
        return [];
    }
  }
// ... (Add dispose method to clean up controllers)
}
