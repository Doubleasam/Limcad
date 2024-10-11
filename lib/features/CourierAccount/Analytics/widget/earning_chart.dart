import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EarningsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
              color: Colors.grey,
              onPressed: () {},
            ),
            IconButton(
              iconSize: 20,
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          width: 400,
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBar("Nov", 248700, highlighted: true),
              _buildBar("Dec", 198000),
              _buildBar("Jan", 235000),
              _buildBar("Feb", 190000),
              _buildBar("Mar", 10000),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBar(String month, double amount, {bool highlighted = false}) {
    double maxBarHeight = 150;
    double barHeight = (amount / 300000) * maxBarHeight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '₦${amount.toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Container(
            width: 20,
            height: barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade700],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(height: 4),
          if (highlighted)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                month,
                style: TextStyle(color: Colors.white),
              ),
            )
          else
            Text(month),
        ],
      ),
    );
  }
}
