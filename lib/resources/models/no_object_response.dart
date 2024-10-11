
import 'package:limcad/resources/api/from_json.dart';

class NoObjectResponse implements FromJson<NoObjectResponse> {
  @override
  NoObjectResponse fromJson(Map<String, dynamic> json) {
    return NoObjectResponse();
  }
}

