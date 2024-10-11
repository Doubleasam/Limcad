// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';

class CourierHomeScreen extends StatefulWidget {
  static String routeName = "/courierHomeScreen";
  @override
  State<CourierHomeScreen> createState() => _CourierHomeScreenState();
}

class _CourierHomeScreenState extends State<CourierHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: const Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/veriswipe-dev-77924.appspot.com/o/profile_pictures%2FfOLM7PP2ILceW4lfGiEVbY0jBiI2%2Fprofile_image?alt=media&token=d9d5b9fd-d5ae-4c76-80db-158d852870f9"),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back,', style: TextStyle(fontSize: 15)),
            Text('David Alaba',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEarningsSummary().paddingOnly(top: 30),
              SizedBox(height: 16),
              _buildStatsSection(),
              SizedBox(height: 16),
              _buildDeliveryRequestSection(),
              SizedBox(height: 16),
              _buildDeliveryHistorySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Earnings Summary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "See all",
                style: TextStyle(color: Color(0xFF2980B9)),
              ),
            ),
          ],
        ).padding(bottom: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          color: Color(0xFF6D02C0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today\'s earning',
                        style: TextStyle(color: Colors.white)),
                    Text('View more →', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 8),
                Text('₦12,000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total requests'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('128',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Image.asset(
                        AssetUtil.greenArrow,
                        width: 16,
                        height: 16,
                      ).paddingRight(10),
                      Text('23.45%', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total deliveries'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('122',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Image.asset(
                        AssetUtil.greenArrow,
                        width: 16,
                        height: 16,
                      ).paddingRight(10),
                      Text('23.45%', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryRequestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery request',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_sharp, size: 16, color: Color(0xFF2980B9)),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDeliveryRequestItem(),
              _buildDeliveryRequestItem(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryRequestItem() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/veriswipe-dev-77924.appspot.com/o/profile_pictures%2FfOLM7PP2ILceW4lfGiEVbY0jBiI2%2Fprofile_image?alt=media&token=d9d5b9fd-d5ae-4c76-80db-158d852870f9'),
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Helen Laundry',
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text('4.5').padding(right: 10),
                    Text('30+ Deliveries'),
                  ],
                ),
              ],
            ),
            Image.asset(AssetUtil.greenDot, width: 30, height: 30)
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery history',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('View all', style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 16),
        _buildDeliveryHistoryItem(),
        _buildDeliveryHistoryItem(),
        _buildDeliveryHistoryItem(),
        _buildDeliveryHistoryItem(),
      ],
    );
  }

  Widget _buildDeliveryHistoryItem() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/veriswipe-dev-77924.appspot.com/o/profile_pictures%2FfOLM7PP2ILceW4lfGiEVbY0jBiI2%2Fprofile_image?alt=media&token=d9d5b9fd-d5ae-4c76-80db-158d852870f9'),
        ),
        title: Text('Helen Laundry'),
        subtitle: Text('Delivery: Today, 03:30pm'),
        trailing: Text('See details', style: TextStyle(color: Colors.blue)),
      ),
    ).paddingBottom(10);
  }
}
