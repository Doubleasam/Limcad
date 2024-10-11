import 'package:flutter/material.dart';
import 'package:limcad/features/giftcards/services/gift_card_service.dart';

import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/locator.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';

enum GiftCardType { DISCOUNT, BIRTHDAY, WEDDING, GRADUATION, OTHER }

extension GiftCardTypeExtension on GiftCardType {
  String get name {
    switch (this) {
      case GiftCardType.DISCOUNT:
        return 'Discount';
      case GiftCardType.BIRTHDAY:
        return 'Birthday';
      case GiftCardType.WEDDING:
        return 'Wedding';
      case GiftCardType.GRADUATION:
        return 'Graduation';
      case GiftCardType.OTHER:
        return 'Other';
    }
  }
}

class GiftCardViewModel extends BaseVM {
  final _giftCardService = locator<GiftCardService>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientName = TextEditingController();
  final TextEditingController senderName = TextEditingController();
  final TextEditingController senderEmail = TextEditingController();
  final TextEditingController senderMessage = TextEditingController();
  late BuildContext context;

  init(BuildContext context) {}

  void selectRecipient(String name) {
    recipientName.text = name;
    print('Selected recipient: $name');
    notifyListeners();
  }

  Future<void> submitGiftCard() async {
    final response = await _giftCardService.submitGiftCard(
        amountController.text.toInt(),
        senderEmail.text,
        GiftCardType.DISCOUNT.name);

    if (response.status == 200) {
      Logger().i(response.data);
    }
  }
}
