import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/base_response.dart';
import 'package:limcad/resources/api/route.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/models/no_object_response.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class GiftCardService with ListenableServiceMixin {
  final apiService = locator<APIClient>();

  Future<BaseResponse<NoObjectResponse>> submitGiftCard(
    int amount,
    String email,
    String giftCardType,
  ) async {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(tomorrow);
    final request = {
      "amount": amount,
      "issuedTo": [email],
      "expiresAt": formattedDate,
      "giftType": giftCardType
    };

    final response = await apiService.request(
      route: ApiRoute(ApiType.giftCard),
      data: request,
      create: () => BaseResponse<NoObjectResponse>(
        create: () => NoObjectResponse(),
      ),
    );

    return response.response;
  }
}
