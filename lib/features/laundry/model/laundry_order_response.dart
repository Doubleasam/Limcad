import 'package:limcad/resources/api/from_json.dart';

class LaundryOrderResponse implements FromJson<LaundryOrderResponse> {
  Id? id;
  Item? item;
  int? quantity;

  LaundryOrderResponse({this.id, this.item, this.quantity});

  LaundryOrderResponse fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    quantity = json['quantity'];
    return this;
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

class Id {
  int? itemId;
  int? orderId;

  Id({this.itemId, this.orderId});

  Id.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['orderId'] = this.orderId;
    return data;
  }
}

class Item {
  String? createdAt;
  int? id;
  String? itemDescription;
  String? itemName;
  int? price;
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
