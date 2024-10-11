import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/order/order_details.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class OrdersPage extends StatefulWidget {
  static const String routeName = "/orders";

  const OrdersPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late LaundryVM model;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
        viewModelBuilder: () => LaundryVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.init(context, LaundryOption.orders, );
        },
        builder: (BuildContext context, model, child) => DefaultScaffold2(
              showAppBar: true,
              includeAppBarBackButton: true,
              title: "Orders",
              backgroundColor: CustomColors.backgroundColor,
              busy: model.loading,
              body: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 10,
                    bottom: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedTab = index; // Update the current tab index
                        });
                        print(index);
                      },
                      indicator: BoxDecoration(
                          color: CustomColors.limcadPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      labelColor: Colors.white, // Selected tab text color
                      unselectedLabelColor:
                          Colors.black, // Unselected tab text color
                      indicatorColor: CustomColors.limcadPrimary,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Josefin Sans"),
                      tabs: const [
                        Tab(
                          text: "Ongoing",
                        ),
                        Tab(
                          text: "Completed",
                        ),
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              width: context.width(),
                              child: ListView.builder(
                                itemCount: model.laundryOrderItems
                                    ?.where((element) =>
                                        element.status != "COMPLETED")
                                    .length,
                                itemBuilder: (context, index) {
                                  final pendingOrders = model.laundryOrderItems
                                      ?.where((element) =>
                                          element.status != "COMPLETED")
                                      .toList();
                                  var item = pendingOrders![index];
                                  return ListTile(
                                    onTap: () {
                                      NavigationService.pushScreen(context,
                                          screen: OrdersDetailsPage(item.id),
                                          withNavBar: true);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.organization?.name ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: "Josefin Sans",
                                                  color: Colors.black),
                                            ).padding(bottom: 8),
                                            Text(
                                              'Order ${item.id}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: "Josefin Sans",
                                                  color: Colors.black),
                                            ).padding(bottom: 8),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '8th Apr, 2024, 4:50',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: "Josefin Sans",
                                              color: grey),
                                        ).padding(bottom: 8),
                                        Text(
                                          item.status ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: "Josefin Sans",
                                              color:
                                                  CustomColors.limcadPrimary),
                                        ).padding(bottom: 8),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: context.width(),
                              child: ListView.builder(
                                itemCount: model.laundryOrderItems
                                    ?.where((element) =>
                                        element.status == "COMPLETED")
                                    .length,
                                itemBuilder: (context, index) {
                                  final completedOrders = model
                                      .laundryOrderItems
                                      ?.where((element) =>
                                          element.status == "COMPLETED")
                                      .toList();
                                  var item = completedOrders![index];
                                  return ListTile(
                                    onTap: () {
                                      NavigationService.pushScreen(context,
                                          screen: OrdersDetailsPage(item.id),
                                          withNavBar: true);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.organization?.name ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: "Josefin Sans",
                                                  color: black),
                                            ).padding(bottom: 8),
                                            Text(
                                              'Order ${item.id}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: "Josefin Sans",
                                                  color: black),
                                            ).padding(bottom: 8),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '8th Apr, 2024, 4:50',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: "Josefin Sans",
                                              color: grey),
                                        ).padding(bottom: 8),
                                        Text(
                                          item.status ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: "Josefin Sans",
                                              color:
                                                  CustomColors.limcadPrimary),
                                        ).padding(bottom: 8),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     FocusScope.of(context).unfocus();
                      //     model.proceed();
                      //   },
                      //   child: const Text("Order Now",
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      //   ),
                      // ).paddingSymmetric(vertical: 32).hideIf(selectedTab != 0),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 16, vertical: 30),
            ));
  }

  Widget OrdersListWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            NavigationService.pushScreen(context,
                screen: OrdersDetailsPage(model.orderId), withNavBar: true);
          },
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Helen Laundry',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                  Text(
                    'Order 2836143',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Josefin Sans",
                        color: black),
                  ).padding(bottom: 8),
                ],
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8th Apr, 2024, 4:50',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey),
              ).padding(bottom: 8),
              Text(
                'View timeline',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: CustomColors.limcadPrimary),
              ).padding(bottom: 8),
            ],
          ),
        ),
      ],
    );
  }
}
