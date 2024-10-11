import 'package:limcad/resources/api/from_json.dart';

class OrderOrganization {
  int? id;
  String? name;

  OrderOrganization({this.id, this.name});

  OrderOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LaundryOrderItem {
  int? id;
  OrderOrganization? organization;
  String? status;

  LaundryOrderItem({this.id, this.organization, this.status});

  LaundryOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'] != null
        ? OrderOrganization.fromJson(json['organization'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class LaundryOrders implements FromJson<LaundryOrders> {
  int? currentPage;
  List<LaundryOrderItem>? items;
  int? totalItems;
  int? totalPages;

  LaundryOrders({this.currentPage, this.items, this.totalItems, this.totalPages});

  @override
  LaundryOrders fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <LaundryOrderItem>[];
      json['items'].forEach((v) {
        items!.add(LaundryOrderItem.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    return data;
  }
}
