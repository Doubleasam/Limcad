import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/order/business_order_details.dart';
import 'package:limcad/features/order/order_details.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class BusinessOrdersPage extends StatefulWidget {
  static const String routeName = "/orders";

  const BusinessOrdersPage({Key? key}) : super(key: key);

  @override
  State<BusinessOrdersPage> createState() => _BusinessOrdersPageState();
}

class _BusinessOrdersPageState extends State<BusinessOrdersPage> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.businessOrder);
      },
      builder: (BuildContext context, model, child) => DefaultScaffold2(
        busy: model.loading,
        includeAppBarBackButton: false,
        overrideBackButton: (){

        },
        body: Container(
          padding: const EdgeInsets.all(16),
          width: context.width(),
          height: context.height(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [32.height, Expanded(child: OrdersListWidget(context, model))],
          ).paddingSymmetric(horizontal: 16, vertical: 30),
        ),
      )
    );
  }

  Widget OrdersListWidget(BuildContext context, LaundryVM model) {
    return ListView.builder(
      itemCount: model.businessLaundryOrderItems?.length,
      itemBuilder: (context, index) {
        final order = model.businessLaundryOrderItems?[index];
        return Container(
          width: MediaQuery.of(context).size.width - 38,
          decoration: boxDecorationRoundedWithShadow(
            18,
            backgroundColor: white,
          ),
          child: ListTile(
            onTap: () {
              NavigationService.pushScreen(context,
                  screen: BusinessOrdersDetailsPage(order:order), withNavBar: true);
            },
            horizontalTitleGap: 8,
            leading: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                width: 50,
                height: 50,
                child: placeHolderWidget(height: 50, width: 50, radius: 25)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(order?.customer?.name ?? 'Unknown',
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle(
                              size: 24, weight: FontWeight.w500)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18.34,
                        ),
                        Text('4.5',
                            style: primaryTextStyle(
                                size: 13, weight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ).paddingBottom(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Phone: ${order?.customer?.phoneNumber ?? 'N/A'}',
                        style: primaryTextStyle(
                            size: 14,
                            color: Colors.black.withOpacity(0.6),
                            weight: FontWeight.w400))
                        .paddingBottom(8),
                    SizedBox(
                      width: 200,
                      child: Text('Email: ${order?.customer?.email ?? 'N/A'}',
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle(
                              size: 14,
                              color: Colors.black.withOpacity(0.6),
                              weight: FontWeight.w400))
                          .paddingBottom(8),
                    ),
                    Text('Delivery: Today, 03:30pm',
                        style: primaryTextStyle(
                            size: 14,
                            color: Colors.black.withOpacity(0.6),
                            weight: FontWeight.w400))
                        .paddingBottom(8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status: ${order?.status ?? 'N/A'}',
                            style: primaryTextStyle(
                                size: 14,
                                color: Colors.black.withOpacity(0.6),
                                weight: FontWeight.w400))
                            .paddingBottom(8),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.limcadPrimary),
                          width: 28,
                          height: 28,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: white,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).paddingTop(13),
          ),
        ).paddingBottom(32);
      },
    );
  }
}
