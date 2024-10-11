import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/giftcards/model/gift_card_vm.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';
import 'customize_card_screen.dart';
import 'saved_recipients_screen.dart';
import 'gift_card_preview_screen.dart';

// [ DISCOUNT, BIRTHDAY, WEDDING, GRADUATION, OTHER ]
class SelectedCardScreen extends StatefulWidget {
  @override
  _SelectedCardScreenState createState() => _SelectedCardScreenState();
}

class _SelectedCardScreenState extends State<SelectedCardScreen> {
  String _selectedOption = 'email';
  late GiftCardViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => GiftCardViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context);
      },
      builder: (BuildContext context, model, child) {
        return DefaultScaffold2(
          showAppBar: true,
          title: 'Selected Card',
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Design your card',
                            style: secondaryTextStyle(
                                weight: FontWeight.w500,
                                size: 16,
                                color: black)),
                        Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.2),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text('Change card',
                                  textAlign: TextAlign.center,
                                  style: secondaryTextStyle(
                                    color: CustomColors.blackPrimary,
                                    size: 12,
                                  )),
                            )),
                      ]).paddingBottom(10),
                  Card(
                    child: placeHolderWidget(
                        height: 120,
                        width: MediaQuery.of(context)
                            .size
                            .width), // replace with your image
                  ),
                  const SizedBox(height: 10),
                  CustomTextArea(
                    controller: model.amountController,
                    label: "Please, enter preferred amount starting from N500",
                    labelText: "Enter preferred amount",
                  ).paddingBottom(24),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Who is the receiver?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SavedRecipientsScreen(
                                      model: model,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "See Recipient",
                                style: TextStyle(
                                    color: CustomColors.appBlue, fontSize: 11),
                              )),
                        ],
                      ),
                      CustomTextArea(
                        controller: model.recipientName,
                        label: 'Who is the receiver?',
                        labelText: "Enter Recipient Name",
                      ).paddingBottom(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Save Recipient",
                            style: TextStyle(
                              color: Color(0xFF3E3E3E),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ).padding(bottom: 4),
                          SizedBox(
                            height: 22,
                            width: 40,
                            child: FittedBox(
                              child: CupertinoSwitch(
                                activeColor: CustomColors.limcadPrimary,
                                value: false,
                                onChanged: (value) {
                                  setState(() {
                                    value = !value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ).padding(bottom: 16),
                    ],
                  ).paddingBottom(24),
                  Text("Who is the sender?").paddingBottom(10),
                  CustomTextArea(
                    controller: model.senderName,
                    label: 'Who is the sender?',
                    labelText: "Enter Sender Name",
                  ).paddingBottom(24),
                  const SizedBox(height: 16),
                  const Text('How do you want them to receive it?'),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OptionButton(
                        text: 'Send via email',
                        isSelected: _selectedOption == 'email',
                        onTap: () {
                          setState(() {
                            _selectedOption = 'email';
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      OptionButton(
                        text: 'Share preferred link',
                        isSelected: _selectedOption == 'link',
                        onTap: () {
                          setState(() {
                            _selectedOption = 'link';
                          });
                        },
                      ),
                    ],
                  ).paddingBottom(24),
                  CustomTextArea(
                    controller: model.senderEmail,
                    label: 'Recipient’s email address?',
                    labelText: "Enter Sender Email",
                  ).paddingBottom(24),
                  CustomTextArea(
                    controller: model.senderMessage,
                    label: 'Leave a message for recipient',
                    labelText: "Leave a message for recipient (Optional)",
                    maxLines: 5,
                  ).paddingBottom(24),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            textStyle:
                                MaterialStateProperty.resolveWith((states) {
                              return const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: "Josefin Sans");
                            }),
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                              } else {
                                return CustomColors.blueBrightColor;
                              }
                            }),
                            shape: MaterialStateProperty.resolveWith((states) {
                              return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10));
                            }),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 0),
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => const Size(double.infinity, 48))),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => GiftCardPreviewScreen(),
                          );
                        },
                        child: const Text('Preview card'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await model.submitGiftCard();
                        },
                        child: const Text('Go to checkout'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
