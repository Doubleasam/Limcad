import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:limcad/features/wallet/models/wallet_vm.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {


  late WalletVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletVM>.reactive(
        viewModelBuilder: () => WalletVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.init(context, WalletOption.wallet);
        },
        builder: (BuildContext context, model, child) => Scaffold(
          body:
          DefaultScaffold2(
            showAppBar: true,
            title: 'Wallet',
            backgroundColor: white,
            body: SingleChildScrollView(
              // If content might overflow
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.limcadPrimary),
                        width: 24,
                        height: 24,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      8.width,
                      const Text(
                        "Add money to wallet",
                        style: TextStyle(
                            fontSize: 16, color: black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ).paddingBottom(16),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.blackPrimary),
                    width: MediaQuery.of(context).size.width,
                    height: 131,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Available balance",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.w500),
                            ).padding(top: 8),
                            Row(
                              children: [
                                const Text(
                                  "Transactions",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: white,
                                      fontWeight: FontWeight.w500),
                                ).padding(top: 8),
                                8.width,
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: white,
                                ).padding(top: 8)
                              ],
                            ).padding(right: 21),
                          ],
                        ).padding(left: 21, top: 27, bottom: 16),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₦6,000.00",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ).padding(left: 16)
                      ],
                    ),
                  ),
                  16.height,
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.limcardFaint),
                    width: MediaQuery.of(context).size.width,
                    height: 76,
                    padding: EdgeInsets.all(7),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Text(
                                "Add money to your wallet using your virtual account number",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.limcadPrimary),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 62,
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 11,
                                      top: 7,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Virtual account number",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: white,
                                                fontWeight: FontWeight.w500),
                                          ).paddingBottom(4),

                                          Text(
                                            "3547958563",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: white,
                                                fontWeight: FontWeight.w500),
                                          )

                                        ],
                                      )),


                                  Positioned(
                                      right: 7,
                                      top: 21,
                                      bottom: 21,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(IconsaxBold.copy, color: white, size: 16,).paddingTop(4),
                                          3.width,
                                          Text(
                                            "Copy",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: white,
                                                fontWeight: FontWeight.w400),
                                          ).paddingTop(4)

                                        ],
                                      )),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  32.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: CustomColors.limcadPrimary,
                        size: 20,
                      ),
                      8.width,
                      const Text(
                        "Manage cards",
                        style: TextStyle(
                            fontSize: 16, color: black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ).paddingBottom(16),

                  Container(
                    height: 48,
                    color: CustomColors.backgroundColor,
                    child: Center(
                      child:  ListTile(
                        title: Text(
                          "******4536",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: Image.asset(AssetUtil.masterCardIcon,   width: 32,
                          height: 24,),
                        trailing: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  24.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.limcadPrimary),
                        width: 16,
                        height: 16,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      8.width,
                      const Text(
                        "Add another card",
                        style: TextStyle(
                            fontSize: 14, color: black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ).paddingBottom(16),


                ],
              ).paddingSymmetric(vertical: 40, horizontal: 16),
            ),
          )
        ));
  }




  // Helper to build sections
  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              ...items,
            ],
          ),
        )
      ],
    );
  }
}
