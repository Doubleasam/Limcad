import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:nb_utils/nb_utils.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      includeAppBarBackButton: true,
      title: "FAQ",
      backgroundColor: white,
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
            bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: CustomColors.limcadPrimary),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              labelColor: CustomColors.limcadPrimary, // Selected tab text color
              unselectedLabelColor: Colors.black, // Unselected tab text color
              indicatorColor:  CustomColors.limcadPrimary,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily:  "Josefin Sans"),
              tabs: [
                Tab(text: 'Customers'),
                Tab(text: 'Agents'),
                Tab(text: 'Riders'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FAQCategory(
                items: [
                  'How do I register my business?',
                  'How can I update the status of a laundry order?',
                  'What if I need to reschedule a laundry pickup?',
                ],
                answers: [
                  'To register your laundry business, go to the app\'s registration page, provide your business details, including location and services offered, and submit the required documents for verification. Once approved, you can start receiving orders from customers.',
                  'After picking up an order, navigate to the app\'s dashboard, select the active order, and update the status (e.g., washing, drying, ironing). This helps customers track the progress of their orders and ensures transparency throughout the process.',
                  'If you need to reschedule a pickup due to unforeseen circumstances, please notify the customer directly through the app messaging feature. Communicate the new pickup time and ensure that the customer is informed and accommodated.',
                ],
              ),
              FAQCategory(
                items: [
                  'How do I register my business?',
                  'How can I update the status of a laundry order?',
                  'What if I need to reschedule a laundry pickup?',
                ],
                answers: [
                  'To register your laundry business, go to the app\'s registration page, provide your business details, including location and services offered, and submit the required documents for verification. Once approved, you can start receiving orders from customers.',
                  'After picking up an order, navigate to the app\'s dashboard, select the active order, and update the status (e.g., washing, drying, ironing). This helps customers track the progress of their orders and ensures transparency throughout the process.',
                  'If you need to reschedule a pickup due to unforeseen circumstances, please notify the customer directly through the app messaging feature. Communicate the new pickup time and ensure that the customer is informed and accommodated.',
                ],
              ),
              FAQCategory(
                items: [
                  'How do I register my business?',
                  'How can I update the status of a laundry order?',
                  'What if I need to reschedule a laundry pickup?',
                ],
                answers: [
                  'To register your laundry business, go to the app\'s registration page, provide your business details, including location and services offered, and submit the required documents for verification. Once approved, you can start receiving orders from customers.',
                  'After picking up an order, navigate to the app\'s dashboard, select the active order, and update the status (e.g., washing, drying, ironing). This helps customers track the progress of their orders and ensures transparency throughout the process.',
                  'If you need to reschedule a pickup due to unforeseen circumstances, please notify the customer directly through the app messaging feature. Communicate the new pickup time and ensure that the customer is informed and accommodated.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQCategory extends StatelessWidget {
  final List<String> items;
  final List<String> answers;

  FAQCategory({required this.items, required this.answers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ).paddingBottom(50),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            answers[index],
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}


