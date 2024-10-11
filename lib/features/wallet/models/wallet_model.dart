import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class WalletModel implements FromJson<WalletModel> {
  double? balance;
  String? createdAt;
  Customer? customer;
  int? id;
  String? updatedAt;

  WalletModel({this.balance, this.createdAt, this.customer, this.id, this.updatedAt});

  WalletModel fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    createdAt = json['createdAt'];
    customer = json['customer'] != null ? Customer().fromJson(json['customer']) : null;
    id = json['id'];
    updatedAt = json['updatedAt'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['createdAt'] = createdAt;
    data['customer'] = customer;
    data['id'] = id;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Customer {
  List<Address>? addresses;
  String? createdAt;
  String? email;
  bool? enabled;
  int? id;
  bool? identityVerified;
  String? name;
  String? phoneNumber;
  bool? verified;
  String? updatedAt;

  Customer({
    this.addresses,
    this.createdAt,
    this.email,
    this.enabled,
    this.id,
    this.identityVerified,
    this.name,
    this.phoneNumber,
    this.verified,
    this.updatedAt,
  });

  Customer fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses!.add(Address.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    email = json['email'];
    enabled = json['enabled'];
    id = json['id'];
    identityVerified = json['identityVerified'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    verified = json['verified'];
    updatedAt = json['updatedAt'];
    return this;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addresses'] = addresses;
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['id'] = id;
    data['enabled'] = enabled;
    data['identityVerified'] = identityVerified;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['verified'] = verified;
    data['updatedAt'] = updatedAt;
    return data;
  }
}