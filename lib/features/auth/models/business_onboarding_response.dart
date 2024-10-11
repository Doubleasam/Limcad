import 'package:limcad/resources/api/from_json.dart';
import 'package:limcad/resources/models/general_response.dart';

class BusinessOnboardingResponse
    implements FromJson<BusinessOnboardingResponse> {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Organization? organization;

  bool? verified;
  bool? enabled;
  bool? identityVerified;
  String? idPath;
  String? nin;
  String? gender;

  String? createdAt;
  String? updatedAt;

  BusinessOnboardingResponse(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.organization,
      this.verified,
      this.enabled,
      this.identityVerified,
      this.idPath,
      this.nin,
      this.gender,
      this.createdAt,
      this.updatedAt});

  @override
  BusinessOnboardingResponse fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;

    verified = json['verified'];
    enabled = json['enabled'];
    identityVerified = json['identityVerified'];
    idPath = json['idPath'];
    nin = json['nin'];
    gender = json['gender'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }

    data['verified'] = this.verified;
    data['enabled'] = this.enabled;
    data['identityVerified'] = this.identityVerified;
    data['idPath'] = this.idPath;
    data['nin'] = this.nin;
    data['gender'] = this.gender;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Organization {
  int? id;
  String? name;
  String? address;
  String? location;
  String? email;
  String? phoneNumber;
  LaundryAbout? laundryAbout;
  bool? paymentSetup;

  String? createdAt;
  bool? enabled;
  String? updatedAt;

  Organization(
      {this.id,
      this.name,
      this.address,
      this.location,
      this.email,
      this.phoneNumber,
      this.laundryAbout,
      this.paymentSetup,
      this.createdAt,
      this.enabled,
      this.updatedAt});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    location = json['location'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    laundryAbout = json['laundryAbout'] != null
        ? new LaundryAbout.fromJson(json['laundryAbout'])
        : null;
    paymentSetup = json['paymentSetup'];

    createdAt = json['createdAt'];
    enabled = json['enabled'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    if (this.laundryAbout != null) {
      data['laundryAbout'] = this.laundryAbout!.toJson();
    }
    data['paymentSetup'] = this.paymentSetup;

    data['createdAt'] = this.createdAt;
    data['enabled'] = this.enabled;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class LaundryAbout {
  int? id;
  String? aboutText;
  String? createdAt;
  String? updatedAt;

  LaundryAbout({this.id, this.aboutText, this.createdAt, this.updatedAt});

  LaundryAbout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutText = json['aboutText'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aboutText'] = this.aboutText;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
