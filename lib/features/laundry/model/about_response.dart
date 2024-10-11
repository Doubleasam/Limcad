import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class AboutResponse implements FromJson<AboutResponse> {
  int? id;
  String? aboutText;


  AboutResponse({
    this.id,
    this.aboutText,

  });

  @override
  AboutResponse fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutText = json['aboutText'];

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aboutText'] = aboutText;

    return data;
  }
}