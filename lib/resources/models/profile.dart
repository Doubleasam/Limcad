import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class ProfileResponse implements FromJson<ProfileResponse> {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  bool? verified;
  bool? enabled;
  bool? identityVerified;
  String? idPath;
  String? nin;
  String? gender;
  List<Address>? address;
  String? createdAt;
  String? updatedAt;

  ProfileResponse({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.verified,
    this.enabled,
    this.identityVerified,
    this.idPath,
    this.nin,
    this.gender,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  @override
  ProfileResponse fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    verified = json['verified'];
    enabled = json['enabled'];
    identityVerified = json['identityVerified'];
    idPath = json['idPath'];
    nin = json['nin'];
    gender = json['gender'];
    if (json['addresses'] != null) {
      address = <Address>[];
      json['addresses'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['verified'] = verified;
    data['enabled'] = enabled;
    data['identityVerified'] = identityVerified;
    data['idPath'] = idPath;
    data['nin'] = nin;
    data['gender'] = gender;
    if (address != null) {
      data['addresses'] = address!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'ProfileResponse{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, '
        'verified: $verified, enabled: $enabled, identityVerified: $identityVerified, '
        'idPath: $idPath, nin: $nin, gender: $gender, '
        'address: ${address?.map((a) => a.toString()).toList()}, '
        'createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
