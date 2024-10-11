import 'package:limcad/resources/api/from_json.dart';

class OrderItemsResponse implements FromJson<OrderItemsResponse> {
  int? currentPage;
  List<OrderItem>? items;
  int? totalItems;
  int? totalPages;

  OrderItemsResponse({this.currentPage, this.items, this.totalItems, this.totalPages});

  @override
  OrderItemsResponse fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
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
    return 'OrderItemsResponse{currentPage: $currentPage, items: $items, totalItems: $totalItems, totalPages: $totalPages}';
  }
}

class OrderItem {
  ItemId? id;
  Item? item;
  Order? order;
  int? quantity;

  OrderItem({this.id, this.item, this.order, this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] != null ? ItemId.fromJson(json['id']) : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }

  @override
  String toString() {
    return 'OrderItem{id: $id, item: $item, order: $order, quantity: $quantity}';
  }
}

class ItemId {
  int? itemId;
  int? orderId;

  ItemId({this.itemId, this.orderId});

  factory ItemId.fromJson(Map<String, dynamic> json) {
    return ItemId(
      itemId: json['itemId'],
      orderId: json['orderId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = this.itemId;
    data['orderId'] = this.orderId;
    return data;
  }

  @override
  String toString() {
    return 'ItemId{itemId: $itemId, orderId: $orderId}';
  }
}

class Item {
  int? id;
  String? itemDescription;
  String? itemName;
  double? price;

  Item({this.id, this.itemDescription, this.itemName, this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemDescription: json['itemDescription'],
      itemName: json['itemName'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['itemDescription'] = this.itemDescription;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    return data;
  }

  @override
  String toString() {
    return 'Item{id: $id, itemDescription: $itemDescription, itemName: $itemName, price: $price}';
  }
}

class Order {
  int? id;
  Organization? organization;
  String? status;

  Order({this.id, this.organization, this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      organization: json['organization'] != null ? Organization.fromJson(json['organization']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'Order{id: $id, organization: $organization, status: $status}';
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
