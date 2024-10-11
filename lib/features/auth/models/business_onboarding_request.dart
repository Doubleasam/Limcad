import 'package:limcad/features/auth/models/signup_request.dart';

class BusinessOnboardingRequest {
  StaffRequest? staffRequest;
  OrganizationRequest? organizationRequest;

  BusinessOnboardingRequest({this.staffRequest, this.organizationRequest});

  BusinessOnboardingRequest.fromJson(Map<String, dynamic> json) {
    staffRequest = json['staffRequest'] != null
        ? new StaffRequest.fromJson(json['staffRequest'])
        : null;
    organizationRequest = json['organizationRequest'] != null
        ? new OrganizationRequest.fromJson(json['organizationRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.staffRequest != null) {
      data['staffRequest'] = this.staffRequest!.toJson();
    }
    if (this.organizationRequest != null) {
      data['organizationRequest'] = this.organizationRequest!.toJson();
    }
    return data;
  }
}

class StaffRequest {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  List<String>? roleEnums;
  String? userType;
  String? gender;
  List<AddressRequest>? addressRequest;

  StaffRequest(
      {this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.roleEnums,
      this.userType,
      this.gender,
      this.addressRequest});

  StaffRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    roleEnums = json['roleEnums'].cast<String>();
    userType = json['userType'];
    gender = json['gender'];
    if (json['addressRequest'] != null) {
      addressRequest = <AddressRequest>[];
      json['addressRequest'].forEach((v) {
        addressRequest!.add(new AddressRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['roleEnums'] = this.roleEnums;
    data['userType'] = this.userType;
    data['gender'] = this.gender;
    if (this.addressRequest != null) {
      data['addressRequest'] =
          this.addressRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrganizationRequest {
  String? name;
  String? address;
  String? location;
  num? longitude;
  num? latitude;
  String? email;
  String? phoneNumber;

  OrganizationRequest(
      {this.name, this.address, this.location, this.longitude, this.latitude, this.email, this.phoneNumber});

  OrganizationRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
