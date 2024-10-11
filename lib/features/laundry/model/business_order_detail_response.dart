import 'dart:ffi';

import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/resources/api/from_json.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';

class BusinessOrderDetailResponse
    implements FromJson<BusinessOrderDetailResponse> {
  Address? address;
  String? createdAt;
  Customer? customer;
  int? id;
  List<OrderItems>? orderItems;
  Organization? organization;
  List<int>? payments;
  String? pickupDate;
  num? price;
  double? amountPaid;
  String? status;
  String? updatedAt;

  BusinessOrderDetailResponse(
      {this.address,
      this.createdAt,
      this.customer,
      this.id,
      this.orderItems,
      this.organization,
      this.payments,
      this.pickupDate,
      this.price,
      this.amountPaid,
      this.status,
      this.updatedAt});

  BusinessOrderDetailResponse fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    createdAt = ViewUtil.formatDate(json['createdAt']);
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    id = json['id'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    payments = json['payments'].cast<int>();
    pickupDate = json['pickupDate'];
    price = json['price'];
    amountPaid = json['amountPaid'];
    status = json['status'];
    updatedAt =  ViewUtil.formatDate(json['updatedAt']);
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['createdAt'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['id'] = this.id;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['payments'] = this.payments;
    data['pickupDate'] = this.pickupDate;
    data['price'] = this.price;
    data['amountPaid'] = this.amountPaid;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'BusinessOrderDetailResponse{address: ${address?.toString()}, createdAt: $createdAt, '
        'customer: ${customer?.toString()}, id: $id, orderItems: ${orderItems?.map((item) => item.toString()).toList()}, '
        'pickupDate: $pickupDate, price: $price, status: $status, updatedAt: $updatedAt}';
  }
}

class Customer {
  List<Address>? address;
  List<Address>? addresses;
  String? createdAt;
  String? email;
  bool? enabled;
  int? id;
  bool? identityVerified;
  String? name;
  String? phoneNumber;
  String? updatedAt;
  bool? verified;

  Customer(
      {this.address,
      this.addresses,
      this.createdAt,
      this.email,
      this.enabled,
      this.id,
      this.identityVerified,
      this.name,
      this.phoneNumber,
      this.updatedAt,
      this.verified});

  Customer.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Address>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Address.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    email = json['email'];
    enabled = json['enabled'];
    id = json['id'];
    identityVerified = json['identityVerified'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    updatedAt = json['updatedAt'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    data['identityVerified'] = this.identityVerified;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['updatedAt'] = this.updatedAt;
    data['verified'] = this.verified;
    return data;
  }
}

class OrderItems {
  Id? id;
  Item? item;
  num? quantity;

  OrderItems({this.id, this.item, this.quantity});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Item {
  String? createdAt;
  int? id;
  String? itemDescription;
  String? itemName;
  double? price;
  String? updatedAt;

  Item(
      {this.createdAt,
      this.id,
      this.itemDescription,
      this.itemName,
      this.price,
      this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    itemDescription = json['itemDescription'];
    itemName = json['itemName'];
    price = json['price'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['itemDescription'] = this.itemDescription;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Organization {
  String? address;
  String? createdAt;
  String? email;
  bool? enabled;
  int? id;
  num? latitude;
  String? location;
  String? logoPath;
  num? longitude;
  String? name;
  bool? paymentSetup;
  String? phoneNumber;
  String? updatedAt;

  Organization(
      {this.address,
      this.createdAt,
      this.email,
      this.enabled,
      this.id,
      this.latitude,
      this.location,
      this.logoPath,
      this.longitude,
      this.name,
      this.paymentSetup,
      this.phoneNumber,
      this.updatedAt});

  Organization.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    createdAt = json['createdAt'];
    email = json['email'];
    enabled = json['enabled'];
    id = json['id'];
    latitude = json['latitude'];
    location = json['location'];
    logoPath = json['logoPath'];
    longitude = json['longitude'];
    name = json['name'];
    paymentSetup = json['paymentSetup'];
    phoneNumber = json['phoneNumber'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['logoPath'] = this.logoPath;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['paymentSetup'] = this.paymentSetup;
    data['phoneNumber'] = this.phoneNumber;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
