import 'package:limcad/resources/api/from_json.dart';

class ChangeProfileResponse implements FromJson<ChangeProfileResponse> {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  bool? verified;
  // AddressResponse? addressResponse;
  String? userType;
  // UserImage? userImage;

  ChangeProfileResponse({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.verified,
    // this.addressResponse,
    this.userType,
    // this.userImage
  });

  @override
  ChangeProfileResponse fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    verified = json['verified'];
    // addressResponse = json['addressResponse'] != null
    //     ? new AddressResponse.fromJson(json['addressResponse'])
    //     : null;
    userType = json['userType'];
    // userImage = json['userImage'] != null
    //     ? new UserImage.fromJson(json['userImage'])
    //     : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['verified'] = this.verified;
    // if (this.addressResponse != null) {
    //   data['addressResponse'] = this.addressResponse!.toJson();
    // }
    data['userType'] = this.userType;
    // if (this.userImage != null) {
    //   data['userImage'] = this.userImage!.toJson();
    // }
    return data;
  }
}

class AddressResponse {
  String? name;
  String? additionalInfo;
  LgaResponse? lgaResponse;

  AddressResponse({this.name, this.additionalInfo, this.lgaResponse});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    lgaResponse = json['lgaResponse'] != null
        ? new LgaResponse.fromJson(json['lgaResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['additionalInfo'] = this.additionalInfo;
    if (this.lgaResponse != null) {
      data['lgaResponse'] = this.lgaResponse!.toJson();
    }
    return data;
  }
}

class LgaResponse {
  int? lgaId;
  String? lgaName;
  StateResponse1? stateResponse;

  LgaResponse({this.lgaId, this.lgaName, this.stateResponse});

  LgaResponse.fromJson(Map<String, dynamic> json) {
    lgaId = json['lgaId'];
    lgaName = json['lgaName'];
    stateResponse = json['stateResponse'] != null
        ? new StateResponse1.fromJson(json['stateResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lgaId'] = this.lgaId;
    data['lgaName'] = this.lgaName;
    if (this.stateResponse != null) {
      data['stateResponse'] = this.stateResponse!.toJson();
    }
    return data;
  }
}

class StateResponse1 {
  String? stateId;
  String? stateName;

  StateResponse1({this.stateId, this.stateName});

  StateResponse1.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    return data;
  }
}

class UserImage {
  int? id;
  int? userId;
  String? path;
  String? userType;

  UserImage({this.id, this.userId, this.path, this.userType});

  UserImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    path = json['path'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['path'] = this.path;
    data['userType'] = this.userType;
    return data;
  }
}
