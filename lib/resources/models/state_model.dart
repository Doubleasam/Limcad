import 'package:limcad/resources/api/from_json.dart';

class StateResponse implements FromJson<StateResponse> {
  String? stateId;
  String? stateName;

  StateResponse({this.stateId, this.stateName});

  @override
  StateResponse fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    stateName = json['stateName'];
    return this;
  }
}

class IdResponse implements FromJson<IdResponse> {
  int? lgaId;
  String? stateId;

  IdResponse({this.lgaId, this.stateId});

  @override
  IdResponse fromJson(Map<String, dynamic> json) {
    lgaId = json['lgaId'];
    stateId = json['stateId'];
    return this;
  }
}

class LGAResponse implements FromJson<LGAResponse> {
  IdResponse? id;
  String? lgaName;
  StateResponse? state;

  LGAResponse({this.id, this.lgaName, this.state});

  @override
  LGAResponse fromJson(Map<String, dynamic> json) {
    id = IdResponse().fromJson(json['id']);
    lgaName = json['lgaName'];
    state = StateResponse().fromJson(json['state']);
    return this;
  }

  static List<LGAResponse> listFromJson(List<dynamic> jsonList) {
    List<LGAResponse> lgaList = [];
    for (var item in jsonList) {
      lgaList.add(LGAResponse().fromJson(item));
    }
    return lgaList;
  }
}

class NewStateResponse implements FromJson<NewStateResponse> {
  int? currentPage;
  List<StateItems>? items;
  int? totalItems;
  int? totalPages;

  NewStateResponse(
      {this.currentPage, this.items, this.totalItems, this.totalPages});

  NewStateResponse fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <StateItems>[];
      json['items'].forEach((v) {
        items!.add(new StateItems.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class StateItems {
  String? stateId;
  String? stateName;

  StateItems({this.stateId, this.stateName});

  StateItems.fromJson(Map<String, dynamic> json) {
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
