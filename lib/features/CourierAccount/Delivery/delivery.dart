import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeliveryHistoryScreen extends StatefulWidget {
  @override
  State<DeliveryHistoryScreen> createState() => _DeliveryHistoryScreenState();
}

class _DeliveryHistoryScreenState extends State<DeliveryHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Delivery history'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'January 2024',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ...List.generate(7, (index) => _buildDeliveryItem()),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: const Padding(
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
                      Icon(Icons.check_circle, color: Colors.green),
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
