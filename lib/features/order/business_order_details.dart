import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/business_orders.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/order/order_details.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class BusinessOrdersDetailsPage extends StatefulWidget {
  static const String routeName = "/BusinessOrdersDetailsPage";
final LaundryOrder? order;
  const BusinessOrdersDetailsPage({
    Key? key, this.order,
  }) : super(key: key);

  @override
  State<BusinessOrdersDetailsPage> createState() =>
      _BusinessOrdersDetailsPageState();
}

class _BusinessOrdersDetailsPageState extends State<BusinessOrdersDetailsPage> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.businessOrderDetails, null,  widget.order?.id);
      },
      builder: (BuildContext context, model, child) => DefaultScaffold2(
        showAppBar: true,
        includeAppBarBackButton: true,
        title: "Order details",
        backgroundColor: CustomColors.backgroundColor,
        busy: model.loading,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              32.height,
              Container(
                  width: MediaQuery.of(context).size.width - 38,
                  decoration: boxDecorationRoundedWithShadow(
                    18,
                    backgroundColor: white,
                  ),
                  child: Column(
                    children: [
                      ViewUtil.eachDetailOrders('Customer info', {
                        'First Name':
                            "${model.businessOrderDetails?.customer?.name}",
                        'Address':
                            "${model.businessOrderDetails?.customer?.addresses?[0].name}",
                        'Phone':
                            "${model.businessOrderDetails?.customer?.phoneNumber}",
                        'Email':
                            "${model.businessOrderDetails?.customer?.email}",
                        'Rating': "4.5",
                        'Verified payment': "₦${model.businessOrderDetails?.amountPaid}",
                      }).paddingSymmetric(vertical: 16, horizontal: 16)
                    ],
                  )).paddingBottom(24),
              Container(
                  width: MediaQuery.of(context).size.width - 38,
                  decoration: boxDecorationRoundedWithShadow(
                    18,
                    backgroundColor: white,
                  ),
                  child: Column(
                    children: [
                      ViewUtil.orderInfo(
                              'Order info',
                              model.orderItems,
                              model.totalPrice)
                          .paddingSymmetric(vertical: 16, horizontal: 16),
                    ],
                  )).paddingBottom(16),
              Container(
                width: MediaQuery.of(context).size.width - 38,
                decoration: boxDecorationRoundedWithShadow(
                  18,
                  backgroundColor: white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order status',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: CustomColors.grey600)),
                    Text("${model.businessOrderDetails?.status?.toLowerCase()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          _showBottomSheet(context, model.businessOrderDetails);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: CustomColors.limcadPrimary,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: CustomColors.limcadPrimary),
                          ),
                          // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        ),
                        child: const Text(
                          'Update',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(vertical: 16, horizontal: 16),
              )
            ],
          ).paddingSymmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, BusinessOrderDetailResponse? businessOrderDetails) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile<String>(
                    title: const Text('Pending'),
                    value: OrderStatus.PENDING.displayValue,
                    groupValue: model.orderStatus.displayValue,
                    onChanged: (String? value) {
                      setState(() {
                        model.setStatus(OrderStatus.PENDING);
                      });
                    },
                    activeColor: CustomColors.limcadPrimary,
                  ),
                  RadioListTile<String>(
                    title: const Text('In progress'),
                    value: OrderStatus.IN_PROGRESS.displayValue,
                    groupValue: model.orderStatus.displayValue,
                    onChanged: (String? value) {
                      setState(() {
                        model.setStatus(OrderStatus.IN_PROGRESS);
                      });
                    },
                    activeColor: CustomColors.limcadPrimary,
                  ),
                  RadioListTile<String>(
                    title: const Text('Completed'),
                    value: OrderStatus.COMPLETED.displayValue,
                    groupValue: model.orderStatus.displayValue,
                    onChanged: (String? value) {
                      setState(() {
                        model.setStatus(OrderStatus.COMPLETED);
                      });
                    },
                    activeColor: CustomColors.limcadPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        model.updateStatus(model.orderStatus, businessOrderDetails);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.limcadPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                      ),
                      child: const Text(
                        'Update status',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
