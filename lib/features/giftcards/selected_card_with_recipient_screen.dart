import 'package:flutter/material.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'gift_card_preview_screen.dart';

class SelectedCardWithRecipientScreen extends StatefulWidget {
  @override
  _SelectedCardWithRecipientScreenState createState() => _SelectedCardWithRecipientScreenState();
}

class _SelectedCardWithRecipientScreenState extends State<SelectedCardWithRecipientScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      title: 'Selected Card',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: placeHolderWidget(), // replace with your image
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Who is the receiver?',
                hintText: 'Tolu Badejo',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Who is the sender?',
                hintText: 'Rita Adams',
              ),
            ),
            SizedBox(height: 16),
            Text('How do you want them to receive it?'),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Send via email'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Share preferred link'),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Recipient's email address?",
                hintText: 'tolubadejo@gmail.com',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Leave a message for recipient (Optional)',
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => GiftCardPreviewScreen(),
                      );
                    },
                    child: Text('Preview card'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Go to checkout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
