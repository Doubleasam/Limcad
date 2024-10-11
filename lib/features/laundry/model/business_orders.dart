import 'package:limcad/resources/api/from_json.dart';

class BusinessLaundryOrders implements FromJson<BusinessLaundryOrders> {
  int? currentPage;
  List<LaundryOrder>? items;
  int? totalItems;
  int? totalPages;

  BusinessLaundryOrders({this.currentPage, this.items, this.totalItems, this.totalPages});

  @override
  BusinessLaundryOrders fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <LaundryOrder>[];
      json['items'].forEach((v) {
        items!.add(LaundryOrder.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = this.currentPage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    return data;
  }

  @override
  String toString() {
    return 'BusinessLaundryOrders{currentPage: $currentPage, items: $items, totalItems: $totalItems, totalPages: $totalPages}';
  }
}

class LaundryOrder {
  Customer? customer;
  int? id;
  Organization? organization;
  String? status;

  LaundryOrder({this.customer, this.id, this.organization, this.status});

  factory LaundryOrder.fromJson(Map<String, dynamic> json) {
    return LaundryOrder(
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      id: json['id'],
      organization: json['organization'] != null ? Organization.fromJson(json['organization']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['id'] = this.id;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'LaundryOrder{customer: $customer, id: $id, organization: $organization, status: $status}';
  }
}

class Customer {
  String? email;
  int? id;
  String? name;
  String? phoneNumber;
  String? userType;
  bool? verified;

  Customer({this.email, this.id, this.name, this.phoneNumber, this.userType, this.verified});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['userType'] = this.userType;
    data['verified'] = this.verified;
    return data;
  }

  @override
  String toString() {
    return 'Customer{email: $email, id: $id, name: $name, phoneNumber: $phoneNumber, userType: $userType, verified: $verified}';
  }
}

class Organization {
  int? id;
  String? name;

  Organization({this.id, this.name});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return 'Organization{id: $id, name: $name}';
  }
}
