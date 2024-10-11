import 'package:limcad/features/wallet/models/wallet_model.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/base_response.dart';
import 'package:limcad/resources/api/route.dart';
import 'package:limcad/resources/locator.dart';
import 'package:stacked/stacked.dart';

class WalletService with ListenableServiceMixin {
  final apiService = locator<APIClient>();



  Future<BaseResponse<WalletModel>?> getUserWallet(int? id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.getUserWallet,
            routeParams: "$id"),
        create: () => BaseResponse<WalletModel>(
            create: () => WalletModel()));
    return response.response;
  }

  Future<BaseResponse<WalletModel>> createUserWallet(int? id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.createUserWallet,
            routeParams: "$id"),
        create: () => BaseResponse<WalletModel>(
            create: () => WalletModel()));
    return response.response;
  }



}