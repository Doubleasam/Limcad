import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';

class ReferralHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      includeAppBarBackButton: true,
      title: "Referral History",
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Kelly Anderson'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Jimoh Isaq'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Caroline Totcher'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Hardy Magnus'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Cindy Larry'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Amie Enny'),
              subtitle: Text('12.09.2024'),
              leading: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
