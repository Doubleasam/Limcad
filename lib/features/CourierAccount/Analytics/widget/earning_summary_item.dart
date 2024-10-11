import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:nb_utils/nb_utils.dart';

class IncomeSummary extends StatelessWidget {
  final double amount;
  final double percentage;
  final bool isPositive;
  final Widget rightWidget;

  const IncomeSummary({
    Key? key,
    required this.amount,
    required this.percentage,
    required this.isPositive,
    required this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total income',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
                rightWidget,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '₦${amount.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      AssetUtil.greenArrow,
                      width: 16,
                      height: 16,
                    ).paddingRight(10),
                    Text(
                      '${percentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
