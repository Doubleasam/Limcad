import 'package:limcad/resources/api/from_json.dart';

class RegistrationResponse implements FromJson<RegistrationResponse> {
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
  String? userType;

  RegistrationResponse(
      {this.id,
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
      this.userType});

  @override
  RegistrationResponse fromJson(Map<String, dynamic> json) {
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
    userType = json['userType'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
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
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Address {
  int? id;
  String? name;
  String? additionalInfo;
  String? lga;
  num? latitude;
  num? longitude;
  int? lgaId;
  String? stateId;
  LgaReference? lgaReference;
  String? userType;
  int? genericUserId;

  Address({
    this.id,
    this.name,
    this.additionalInfo,
    this.lga,
    this.latitude,
    this.longitude,
    this.lgaId,
    this.stateId,
    this.lgaReference,
    this.userType,
    this.genericUserId,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    lga = json['lga'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    lgaId = json['lgaId'];
    stateId = json['stateId'];
    lgaReference = json['lgaReference'] != null
        ? LgaReference.fromJson(json['lgaReference'])
        : null;
    userType = json['userType'];
    genericUserId = json['genericUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['additionalInfo'] = additionalInfo;
    data['lga'] = lga;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['lgaId'] = lgaId;
    data['stateId'] = stateId;
    if (lgaReference != null) {
      data['lgaReference'] = lgaReference!.toJson();
    }
    data['userType'] = userType;
    data['genericUserId'] = genericUserId;
    return data;
  }

  @override
  String toString() {
    return '$name';
  }
}

class LgaReference {
  Id? id;
  State? state;
  String? lgaName;

  LgaReference({this.id, this.state, this.lgaName});

  LgaReference.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    lgaName = json['lgaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    data['lgaName'] = lgaName;
    return data;
  }
}

class Id {
  int? lgaId;
  String? stateId;

  Id({this.lgaId, this.stateId});

  Id.fromJson(Map<String, dynamic> json) {
    lgaId = json['lgaId'];
    stateId = json['stateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lgaId'] = lgaId;
    data['stateId'] = stateId;
    return data;
  }
}

class State {
  String? stateId;
  String? stateName;

  State({this.stateId, this.stateName});

  State.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stateId'] = stateId;
    data['stateName'] = stateName;
    return data;
  }
}

class Tokens {
  String? token;
  String? refreshToken;

  Tokens({this.token, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
