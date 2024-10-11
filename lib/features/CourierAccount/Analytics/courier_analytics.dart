import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:limcad/features/CourierAccount/Analytics/widget/earning_chart.dart';
import 'package:limcad/features/CourierAccount/Analytics/widget/earning_summary_item.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';

class EarningsSummary extends StatefulWidget {
  const EarningsSummary({Key? key}) : super(key: key);

  @override
  State<EarningsSummary> createState() => _EarningsSummaryState();
}

class _EarningsSummaryState extends State<EarningsSummary> {
  bool weeklyIsTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Earning summary', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  child: Card(
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 2,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Daily',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
                SizedBox(
                  height: 40,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 2,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              weeklyIsTapped = !weeklyIsTapped;
                            });
                          },
                          child: Text('Weekly'))),
                ),
                SizedBox(
                  height: 40,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 2,
                      child:
                          TextButton(onPressed: () {}, child: Text('Monthly'))),
                ),
                SizedBox(
                  height: 40,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 2,
                      child:
                          TextButton(onPressed: () {}, child: Text('Yearly'))),
                ),
              ],
            ).padding(bottom: 20),
            Card(elevation: 2, child: EarningsChart().padding(bottom: 20))
                .padding(bottom: 20),
            Flexible(
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return !weeklyIsTapped
                      ? _buildAnalyticsItem()
                      : IncomeSummary(
                          amount: 45200,
                          percentage: 23.45,
                          isPositive: true,
                          rightWidget: Text(
                            'View details →',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsItem() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Helen Laundry',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  '₦3,200',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0123 Aliu Olaiya Avenue, Ikeja G.R.A, Ikeja, Lagos State.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 16),
                      SizedBox(width: 4),
                      Text('0.5km',
                          style: TextStyle(color: Colors.blue, fontSize: 12)),
                      SizedBox(width: 16),
                      Icon(Icons.access_time_filled,
                          color: Colors.blue, size: 16),
                      SizedBox(width: 4),
                      Text('12:45pm',
                          style: TextStyle(color: Colors.blue, fontSize: 12)),
                      Spacer(),
                      Image.asset(
                        AssetUtil.greenArrow,
                        width: 16,
                        height: 16,
                      ).paddingRight(10),
                      Text('20%',
                          style: TextStyle(fontSize: 12, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
