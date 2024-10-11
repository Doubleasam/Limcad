// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:limcad/resources/utils/custom_colors.dart';
// import 'package:limcad/resources/utils/extensions/widget_extension.dart';
// import 'package:limcad/resources/widgets/default_scafold.dart';
// import 'package:nb_utils/nb_utils.dart';

// class AnalyticsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultScaffold2(
//       showAppBar: true,
//       includeAppBarBackButton: true,
//       title: "Order details",
//       backgroundColor: CustomColors.backgroundColor,
//       //busy: model.loading,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 StatCard(
//                   title: 'Total orders',
//                   value: '48.4k',
//                   percentage: 23.45,
//                   icon: Icons.shopping_cart,
//                   iconColor: Colors.green,
//                 ),
//                 StatCard(
//                   title: 'Total deliveries',
//                   value: '48.4k',
//                   percentage: 23.45,
//                   icon: Icons.local_shipping,
//                   iconColor: Colors.pink,
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 StatCard(
//                   title: 'Total views',
//                   value: '17.2k',
//                   percentage: -3.22,
//                   icon: Icons.visibility,
//                   iconColor: Colors.blue,
//                 ),
//                 StatCard(
//                   title: 'Total reviews',
//                   value: '38.9k',
//                   percentage: 23.45,
//                   icon: Icons.rate_review,
//                   iconColor: Colors.purple,
//                 ),
//               ],
//             ),
//             SizedBox(height: 32.0),
//             Card(
//               elevation: 4.0,
//               color: CustomColors.rpAnalyticsColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Profile discovery',
//                               style: TextStyle(
//                                 fontSize: 24.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: white
//                               ),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(
//                               '23.45% (from previous month)',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 24.0),
//                     SizedBox(
//                       height: 200.0,
//                       child: BarChart(
//                         BarChartData(
//                           barGroups: _barGroups(),
//                           titlesData: FlTitlesData(
//                             rightTitles: SideTitles(showTitles: false),
//                             leftTitles: SideTitles(showTitles: true),
//                             topTitles: SideTitles(showTitles: false),
//                             bottomTitles: SideTitles(
//                               showTitles: true,
//                               getTitles: (double value) {
//                                 switch (value.toInt()) {
//                                   case 0:
//                                     return 'May 2';
//                                   case 1:
//                                     return 'May 3';
//                                   case 2:
//                                     return 'May 4';
//                                   case 3:
//                                     return 'May 5';
//                                   case 4:
//                                     return 'May 6';
//                                   default:
//                                     return '';
//                                 }
//                               },
//                             ),
//                           ),
//                           borderData: FlBorderData(show: false),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 32.0),
//             Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Data distribution',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'April',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                         Row(
//                           children: [
//                             DataDistributionItem(
//                               label: 'Male',
//                               value: 42,
//                             ),
//                             SizedBox(width: 16.0),
//                             DataDistributionItem(
//                               label: 'Female',
//                               value: 63,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ).paddingSymmetric(vertical: 16, horizontal: 16),
//       ),
//     );
//   }

//   List<BarChartGroupData> _barGroups() {
//     return [
//       BarChartGroupData(
//         x: 0,
//         barRods: [
//           BarChartRodData(y: 8, colors: [Colors.yellow]),
//           BarChartRodData(y: 5, colors: [Colors.lightBlue]),
//         ],
//       ),
//       BarChartGroupData(
//         x: 1,
//         barRods: [
//           BarChartRodData(y: 6, colors: [Colors.yellow]),
//           BarChartRodData(y: 8, colors: [Colors.lightBlue]),
//         ],
//       ),
//       BarChartGroupData(
//         x: 2,
//         barRods: [
//           BarChartRodData(y: 7, colors: [Colors.yellow]),
//           BarChartRodData(y: 6, colors: [Colors.lightBlue]),
//         ],
//       ),
//       BarChartGroupData(
//         x: 3,
//         barRods: [
//           BarChartRodData(y: 9, colors: [Colors.yellow]),
//           BarChartRodData(y: 7, colors: [Colors.lightBlue]),
//         ],
//       ),
//       BarChartGroupData(
//         x: 4,
//         barRods: [
//           BarChartRodData(y: 10, colors: [Colors.yellow]),
//           BarChartRodData(y: 6, colors: [Colors.lightBlue]),
//         ],
//       ),
//     ];
//   }
// }

// class StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final double percentage;
//   final IconData icon;
//   final Color iconColor;

//   StatCard({
//     required this.title,
//     required this.value,
//     required this.percentage,
//     required this.icon,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, color: iconColor, size: 40.0),
//             SizedBox(height: 8.0),
//             Text(
//               title,
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 4.0),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4.0),
//             Text(
//               '${percentage > 0 ? '+' : ''}${percentage.toStringAsFixed(2)}%',
//               style: TextStyle(
//                 color: percentage > 0 ? Colors.green : Colors.red,
//                 fontSize: 16.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DataDistributionItem extends StatelessWidget {
//   final String label;
//   final int value;

//   DataDistributionItem({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 16.0),
//         ),
//         SizedBox(height: 4.0),
//         Text(
//           value.toString(),
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }