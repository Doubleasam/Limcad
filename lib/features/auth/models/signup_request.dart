class AddressRequest {
  String? name;
  String? additionalInfo;
  LgaRequest? lgaRequest;

  AddressRequest({
    this.name,
    this.additionalInfo,
    this.lgaRequest,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['additionalInfo'] = additionalInfo;
    if (lgaRequest != null) {
      data['lgaRequest'] = lgaRequest!.toJson();
    }
    return data;
  }

  AddressRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    lgaRequest = json['lgaRequest'] != null ? LgaRequest.fromJson(json['lgaRequest']) : null;
  }
}

class LgaRequest {
  int? lgaId;
  String? stateId;

  LgaRequest({
    this.lgaId,
    this.stateId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lgaId'] = lgaId;
    data['stateId'] = stateId;
    return data;
  }

  LgaRequest.fromJson(Map<String, dynamic> json) {
    lgaId = json['lgaId'];
    stateId = json['stateId'];
  }
}

class SignupRequest {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? gender;
  List<AddressRequest>? addressRequest;

  SignupRequest({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.gender,
    this.addressRequest,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['gender'] = gender;
    if (addressRequest != null) {
      data['addressRequest'] = addressRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SignupRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    gender = json['gender'];
    if (json['addressRequest'] != null) {
      addressRequest = <AddressRequest>[];
      json['addressRequest'].forEach((v) {
        addressRequest!.add(AddressRequest.fromJson(v));
      });
    }
  }
}
