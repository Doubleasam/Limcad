import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';

class GiftCardPreviewScreen extends StatefulWidget {
  @override
  _GiftCardPreviewScreenState createState() => _GiftCardPreviewScreenState();
}

class _GiftCardPreviewScreenState extends State<GiftCardPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gift card preview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'This is what will be sent to Tolu Badejo',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: placeHolderWidget(height: 150, width: double.infinity), // replace with your image
          ),
          SizedBox(height: 16),
          Text(
            'Tolu, we are asked to deliver a gift to you from Rita! 🥰',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Go to checkout',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

