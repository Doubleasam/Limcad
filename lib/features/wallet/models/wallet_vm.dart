import 'package:flutter/material.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/storage/base_preference.dart';

enum WalletOption {
  wallet,
  transactions,
}


class WalletVM extends BaseVM {
  final apiService = locator<APIClient>();
  //final laundryService = locator<LaundryService>();
  late BuildContext context;
  String title = "";
  bool isPreview = false;
  bool isButtonEnabled = false;
  WalletOption? walletOption;
  late BasePreference _preference;



  void init(BuildContext context, WalletOption walletOpt) async {
    this.context = context;
    this.walletOption = walletOpt;
    _preference = await BasePreference.getInstance();

    if(walletOption == WalletOption.wallet){
      getWallet();
    }



  }

  void getWallet() {

  }


}