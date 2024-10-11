import 'package:limcad/features/auth/models/login_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class GeneralResponse implements FromJson<GeneralResponse> {
  User? user;
  String? otpId;

  GeneralResponse({this.user, this.otpId});

  @override
  GeneralResponse fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User().fromJson(json['user']) : null;

    otpId = json['otpId'];

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['otpId'] = otpId;
    return data;
  }
}
