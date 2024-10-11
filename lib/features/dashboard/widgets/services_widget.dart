import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/dashboard/dashboard.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/laundry_detail.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';


class ServiceItemWidget extends StatefulWidget {
  static String tag = '/CommonWidgets';
  final LaundryItem dataModel;

  ServiceItemWidget(this.dataModel);

  @override
  ServiceItemWidgetState createState() => ServiceItemWidgetState();
}

class ServiceItemWidgetState extends State<ServiceItemWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LaundryDetailScreen(laundry: widget.dataModel);
        }));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      //Use in Hot items, Expiring Soon,New top sellers content
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: placeHolderWidget(
                      height: 108,
                      width: 178,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    width: 37,
                    height: 18,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [ Icon(Icons.star, size: 12.08, color: CustomColors.limcadYellow,),
                        Text("4.5", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, color: black)).padding(left: 2),


                      ],
                    ).paddingSymmetric(vertical: 4, horizontal: 4),
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 16,
                    height: 18,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.rectangle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.bookmark),
                      iconSize: 14,
                      padding: EdgeInsets.zero,
                      color: CustomColors.limcadPrimary,
                      onPressed: () {
                        // Handle ellipsis button pressed
                      },
                    ),
                  ),
                ),
              ],
            ),
            Text(widget.dataModel.name ?? "", overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)).padding(left: 8, bottom: 4),
            // SizedBox(
            //   width: 178,
            //   child: Text(widget.dataModel?.address ?? "",
            //       overflow: TextOverflow.ellipsis,
            //       maxLines: 1,
            //       style: secondaryTextStyle(
            //           color: Colors.black38, size: 14)).padding(left: 8, bottom: 4),
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: CustomColors.limcadPrimary, size: 14),
                  Text(
                    "${widget.dataModel.distance?.toStringAsFixed(2) ?? ''} km",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: grey),
                  ).padding(left: 2),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.access_time_filled_rounded,
                      color: CustomColors.limcadPrimary, size: 14),
                  Text(calculateTimeToPlace(widget.dataModel.distance ?? 0.0), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: grey)).padding(left: 2),

                ],
              ),
            ],).padding(right: 8, left: 8),
            Text("N1,000-N5,000", overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: CustomColors.limcadPrimary)).padding(left: 8, bottom: 8, top: 8),

          ],
        ),
      ),
    );
  }


  String calculateTimeToPlace(double distanceInKm, {double speedInKmPerHour = 60}) {
    // Calculate time in hours
    double timeInHours = distanceInKm / speedInKmPerHour;

    // Convert hours to minutes
    int hours = timeInHours.floor();
    int minutes = ((timeInHours - hours) * 60).round();

    if (hours > 0) {
      return "$hours hr ${minutes > 0 ? "$minutes min" : ""}";
    } else {
      return "$minutes min";
    }
  }
}
