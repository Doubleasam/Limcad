import 'package:flutter/material.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/order_items_response.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

class ViewUtil {
  late BuildContext context;

  static showDynamicDialogWithButton({
    required BuildContext context,
    Color button2outlineColor = CustomColors.limcadPrimary,
    Color button1color = CustomColors.limcadPrimary,
    String title = "",
    required Widget content,
    required String buttonText,
    required VoidCallback dialogAction1,
    VoidCallback? dialogAction2,
    String buttonText2 = "Close",
    bool button2 = false,
    bool titlePresent = true,
    bool barrierDismissible = true,
  }) {
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // Return the value of allowBackNavigation to determine whether to allow or disallow back navigation
              return barrierDismissible;
            },
            child: AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.zero,
                content: SizedBox(
                  width: 328,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (titlePresent)
                        Text(title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge),
                      Column(
                        children: [
                          content,
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(button1color),
                              minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 48),
                              ),
                            ),
                            onPressed: dialogAction1
                            // () {
                            //   Navigator.pop(context);
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               navigatingWidget)); //close Dialog
                            // }
                            ,
                            child: Text(buttonText),
                          ).padding(bottom: 20, top: 10),
                          if (button2)
                            ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                side: BorderSide(color: button2outlineColor),
                              ),
                              onPressed: dialogAction2 ??
                                  () {
                                    Navigator.pop(context); //close Dialog
                                  },
                              child: Text(
                                buttonText2,
                                style: TextStyle(color: button2outlineColor),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  static Widget eachDetailOrders(String title, Map<String, dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            )).padding(bottom: 24, left: 16),
        ...List.generate(
            details.length,
            (index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Changed for even spacing
                  children: [
                    Expanded(
                      child: Text(details.keys.elementAt(index),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: CustomColors.grey600))
                          .padding(left: 16),
                    ),
                    Expanded(
                      child: Text(details.values.elementAt(index) ?? "",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black,
                          )).padding(right: 16),
                    )
                  ],
                ).padding(bottom: 8))
      ],
    );
  }

  static Widget orderInfo(String title, List<OrderItem>? items, double total) {
    final itemCount = items?.length ?? 0;
    final itemList = items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ).padding(bottom: 24, left: 16),

        Row(
          children: [
            Expanded(
              child: const Text(
                "No of items",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: CustomColors.grey600,
                ),
              ).padding(left: 16),
            ),
            Expanded(
              child: Text(
                "$itemCount",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ).padding(right: 16),
            ),
          ],
        ).paddingBottom(20),

        ...List.generate(
          itemList.length,
          (index) {
            final item = itemList[index].item;
            final itemName = item?.itemName ?? 'Unknown Item';
            final itemPrice = item?.price ?? 0.0;
            final quantity = itemList[index].quantity ?? 0;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "$itemName x $quantity",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: CustomColors.grey600,
                    ),
                  ).padding(left: 16),
                ),
                Expanded(
                  child: Text(
                    "₦${itemPrice * quantity}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ).padding(right: 16),
                ),
              ],
            ).padding(bottom: 8);
          },
        ),

        Row(
          children: [
            Expanded(
              child: const Text(
                "Total",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: CustomColors.grey600,
                ),
              ).padding(left: 16),
            ),
            Expanded(
              child: Text(
                "₦$total",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ).padding(right: 16),
            ),
          ],
        ),
      ],
    );
  }

  static showSnackBarDown(String? message, {Color? bgColor, Color? textColor}) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      backgroundColor: bgColor ?? CustomColors.neutral9,
      content: Text(message ?? "",
          style: TextStyle(
              fontSize: 14,
              color: textColor ?? CustomColors.kWhite,
              fontWeight: FontWeight.w500)),
    ));
  }

  static showSnackBar(String? message, bool error) {
    Fluttertoast.showToast(
      backgroundColor: error ? Colors.red : CustomColors.greenPrimary,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static String? replaceLocalhost(String? url) {
    const String oldHost = 'localhost:8080';
    const String newHost = '167.71.185.95';

// Replace the old host with the new one
    return url?.replaceAll(oldHost, newHost);
  }

  static String extractCodeFromUrl(String url) {
    try {
      // Extract the portion after the last '/'
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last;
      } else {
        throw ArgumentError('Invalid URL format');
      }
    } catch (e) {
      // Handle parsing error or invalid URL
      print('Error extracting code: $e');
      return '';
    }
  }


  static Widget bottomSheetCloseIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 24,
        height: 24,
        padding: EdgeInsets.all(3),
        decoration:
        BoxDecoration(shape: BoxShape.circle, color: CustomColors.neutral1),
        child: Center(child: Icon(Icons.close, size: 16, color: CustomColors.blackPrimary)),
      ),
    );
  }

  static String formatDate(String inputDate) {
    // Parse the input date string to a DateTime object
    DateTime dateTime = DateTime.parse(inputDate);

    // Define the desired output format
    DateFormat outputFormat = DateFormat('EEE d, MMM yyyy h:mm a');

    // Format the date
    return outputFormat.format(dateTime);
  }

  static String getOnlyTime(String inputDate) {
    // Parse the input date string to a DateTime object
    DateTime dateTime = DateFormat('EEE d, MMM yyyy h:mm a').parse(inputDate);

    // Define the desired output format for time only
    DateFormat timeFormat = DateFormat('h:mm a');

    // Format the time
    return timeFormat.format(dateTime);
  }
}
