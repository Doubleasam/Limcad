import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';

class GiftCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      includeAppBarBackButton: true,
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Send WakaClean gift cards to your loved ones.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                placeHolderWidget(
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Gifts for special moments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text('My gifts'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  GiftCardCategory(
                    title: 'Birthday',
                    image: 'assets/images/birthday.png', // Replace with your image asset
                  ),
                  GiftCardCategory(
                    title: 'Wedding',
                    image: 'assets/images/wedding.png', // Replace with your image asset
                  ),
                  GiftCardCategory(
                    title: 'Graduation',
                    image: 'assets/images/graduation.png', // Replace with your image asset
                  ),
                  GiftCardCategory(
                    title: 'Child birth',
                    image: 'assets/images/child_birth.png', // Replace with your image asset
                  ),
                  GiftCardCategory(
                    title: 'Friendship',
                    image: 'assets/images/friendship.png', // Replace with your image asset
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

class GiftCardCategory extends StatelessWidget {
  final String title;
  final String image;

  const GiftCardCategory({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          placeHolderWidget(
            width: 80,
            height: 80,
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
