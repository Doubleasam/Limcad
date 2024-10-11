import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class FileResponse implements FromJson<FileResponse> {
  int? id;
  Organization? organization;
  String? path;

  FileResponse({this.id, this.organization, this.path});

  FileResponse fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    path = json['path'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['path'] = this.path;
    return data;
  }
}
