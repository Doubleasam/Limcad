import 'dart:math';

import 'package:camera/camera.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/order/review_page.dart';
import 'package:limcad/features/order/timeline_status.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:timelines/timelines.dart' as timeLine;

class OrdersDetailsPage extends StatefulWidget {
  static const String routeName = "/ordersDetails";
  final int? id;
  const OrdersDetailsPage(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersDetailsPage> createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrdersDetailsPage> {
  late LaundryVM model;

  double kTileHeight = 50.0;

  Color completeColor = const Color(0xff5e6172);
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  int _processIndex = 2;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  // List<Item> items = [
  //   Item('Shirts', 3, 300),
  //   Item('Gown', 1, 200),
  //   Item('Jeans', 1, 300),
  //   Item('Towel', 2, 600),
  // ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
        viewModelBuilder: () => LaundryVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.orderId = widget.id;
          model.init(context, LaundryOption.order_details, null, widget.id);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold2(
              showAppBar: true,
              includeAppBarBackButton: true,
              title: "Order #${model.businessOrderDetails?.id}",
              actions: [
                Row(
                  children: [
                    Container(
                        height: 30,
                        width: 120,
                        decoration: const BoxDecoration(
                            color: CustomColors.limcardSecondary2,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Row(
                            children: [
                              5.width,
                              const Icon(
                                IconsaxBold.repeat,
                                size: 16,
                              ),
                              3.width,
                              Text('Repeat order',
                                  textAlign: TextAlign.start,
                                  style: secondaryTextStyle(
                                    color: CustomColors.blackPrimary,
                                    size: 12,
                                  )),
                            ],
                          ),
                        )),
                  ],
                ).padding(right: 16)
              ],
              backgroundColor: CustomColors.backgroundColor,
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 250,
                        padding: EdgeInsets.zero,
                        child: orderTimeline(context)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.limcadPrimary),
                              width: 8,
                              height: 8,
                            ),
                            16.width,
                            GestureDetector(
                              onTap: () {
                                _orderProgressSheet();
                              },
                              child: Text('View order timeline',
                                  textAlign: TextAlign.start,
                                  style: secondaryTextStyle(
                                      color: CustomColors.limcadPrimaryLight,
                                      size: 12,
                                      weight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.pushScreen(context,
                                screen: ReviewsPage(model.businessOrderDetails),
                                withNavBar: true);
                          },
                          child: Container(
                              height: 30,
                              width: 120,
                              decoration: const BoxDecoration(
                                  color: CustomColors.limcardSecondary2,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text('Drop a review',
                                    textAlign: TextAlign.start,
                                    style: secondaryTextStyle(
                                      color: CustomColors.limcadPrimaryLight,
                                      size: 12,
                                    )),
                              )),
                        ).hideIf(model.businessOrderDetails?.status?.toLowerCase() == "pending"),
                      ],
                    ).padding(bottom: 40),
                    Divider(
                      thickness: 3,
                    ).padding(bottom: 40),
                    ViewUtil.orderInfo(
                        'Order info',
                        model.orderItems,
                        model.totalPrice),
                    // ListView.builder(
                    //     itemCount: items.length,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       return _buildItem(items[index])
                    //           .paddingSymmetric(vertical: 23);
                    //     }).paddingBottom(40),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Sub-total',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //     Text('N1,400'),
                    //   ],
                    // ).paddingBottom(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Delivery',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //     Text('N200'),
                    //   ],
                    // ).paddingBottom(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Service',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //     Text('N200'),
                    //   ],
                    // ).paddingBottom(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Total',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //     Text('N1,800'),
                    //   ],
                    // ).paddingBottom(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Payment method',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //     Text('Online payment',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //             fontFamily: "Josefin Sans",
                    //             color: black)),
                    //   ],
                    // ).paddingBottom(24),
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 46),
              ),
            ));
  }

  _orderProgressSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: TimelineStatusPage()),
        );
      },
    );
  }

  Widget _buildItem(Item item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('${item.name}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: "Josefin Sans",
                    color: black)),
            Text(' x ${item.quantity}',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: "Josefin Sans",
                    color: grey)),
          ],
        ),
        Text('N${item.price}'),
      ],
    );
  }

  Widget orderTimeline(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: 360.0,
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _OrderTitle(
                orderInfo: model.businessOrderDetails,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  final BusinessOrderDetailResponse? orderInfo;

  @override
  Widget build(BuildContext context) {
    return timeLine.FixedTimeline.tileBuilder(
      theme: timeLine.TimelineThemeData(
        nodePosition: 0,
        color: CustomColors.limcadPrimary,
        indicatorTheme: const timeLine.IndicatorThemeData(
          position: 0,
          size: 16.0,
        ),
        connectorTheme: timeLine.ConnectorThemeData(
            color: CustomColors.limcadPrimaryLight.withOpacity(0.5),
            thickness: 5,
            indent: 10),
      ),
      builder: timeLine.TimelineTileBuilder.connected(
        connectionDirection: timeLine.ConnectionDirection.before,
        itemCount: 2,
        contentsBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                index.isEven
                    ? ListTile(
                        onTap: () {},
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
                                  orderInfo?.organization?.name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: "Josefin Sans",
                                      color: black),
                                ).padding(bottom: 8),
                                Text(
                                  orderInfo?.createdAt ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: "Josefin Sans",
                                      color: grey),
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
                              ViewUtil.getOnlyTime(orderInfo!.createdAt!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "Josefin Sans",
                                  color: grey),
                            ).padding(bottom: 8),
                            Text(
                              '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "Josefin Sans",
                                  color: CustomColors.limcadPrimary),
                            ).padding(bottom: 8),
                          ],
                        ),
                      ).padding(bottom: 32)
                    : ListTile(
                        onTap: () {},
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
                                  orderInfo?.customer?.name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: "Josefin Sans",
                                      color: black),
                                ).padding(bottom: 8),
                                Text(
                                  orderInfo?.updatedAt ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: "Josefin Sans",
                                      color: grey),
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
                              ViewUtil.getOnlyTime(orderInfo!.updatedAt!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "Josefin Sans",
                                  color: grey),
                            ).padding(bottom: 8),
                            Text(
                              orderInfo?.status ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "Josefin Sans",
                                  color: CustomColors.limcadPrimary),
                            ).padding(bottom: 8),
                          ],
                        ),
                      ).padding(bottom: 32)
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          if (index.isOdd) {
            return timeLine.DotIndicator(
              color: white,
              child: Icon(
                Icons.location_on,
                color: CustomColors.limcadPrimary,
                size: 16.0,
              ),
            );
          } else {
            return timeLine.OutlinedDotIndicator(
              borderWidth: 3,
              color: CustomColors.limcadPrimaryLight.withOpacity(0.5),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: CustomColors.limcadPrimary),
                width: 8,
                height: 8,
              )),
            );
          }
        },
        connectorBuilder: (_, index, ___) => const timeLine.SolidLineConnector(
          color: null,
        ),
      ),
    );
  }
}

_OrderInfo _data(int id) => _OrderInfo(
      id: id,
      date: DateTime.now(),
    );

class _OrderInfo {
  const _OrderInfo({
    required this.id,
    required this.date,
    // required this.driverInfo,
    // required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
// final _DriverInfo driverInfo;
// final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.messages = const [];

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}

class Item {
  final String name;
  final int quantity;
  final int price;

  Item(this.name, this.quantity, this.price);
}
