import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:limcad/features/giftcards/model/gift_card_vm.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';
import 'selected_card_with_recipient_screen.dart';

class SavedRecipientsScreen extends StatefulWidget {
  final GiftCardViewModel model;

  SavedRecipientsScreen({required this.model});
  @override
  _SavedRecipientsScreenState createState() => _SavedRecipientsScreenState();
}

class _SavedRecipientsScreenState extends State<SavedRecipientsScreen> {
  String? selectedRecipient;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      title: 'Saved Recipients',
      backgroundColor: CustomColors.backgroundGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select recipient',
                      style: secondaryTextStyle(
                          weight: FontWeight.w500, size: 16, color: black)),
                  Container(
                      height: 30,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: CustomColors.limcadPrimary,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Add Recipient',
                            style: secondaryTextStyle(
                              color: white,
                              size: 12,
                            )),
                      )),
                ]).paddingBottom(36),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Select recipient',
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         // Add recipient logic here
            //       },
            //       child: Text('Add recipient'),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  recipientTile('Tolu Badejo').paddingBottom(24),
                  recipientTile('Alfred Marshal').paddingBottom(24),
                  recipientTile('Debo Gbadebo').paddingBottom(24),
                  recipientTile('Ahmed Lawal').paddingBottom(24),
                  recipientTile('Chidi Alex').paddingBottom(24),
                  recipientTile('Mornet Charlie').paddingBottom(24),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.model.recipientName.text.isNotEmpty
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.model.recipientName.text.isNotEmpty
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recipientTile(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.model.recipientName.text = name;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 13),
        decoration: BoxDecoration(
            color: widget.model.recipientName.text == name
                ? CustomColors.limcadPrimary
                : Colors.white,
            border: Border.all(
                color: widget.model.recipientName.text == name
                    ? CustomColors.limcadPrimary
                    : Colors.grey,
                width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetUtil.profileIcon,
              color: widget.model.recipientName.text == name ? white : black,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                  color:
                      widget.model.recipientName.text == name ? white : black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
