import 'package:limcad/resources/api/from_json.dart';

class LaundryServiceItem implements FromJson<LaundryServiceItem> {
  int? id;
  String? itemDescription;
  String? itemName;
  double? price;

  LaundryServiceItem({
    this.id,
    this.itemDescription,
    this.itemName,
    this.price,
  });

  LaundryServiceItem fromJson(Map<String, dynamic> json) {
    id = json["id"];
    itemDescription = json['itemDescription'];
    itemName = json['itemName'];
    price = json['price'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemDescription'] = itemDescription;
    data['itemName'] = itemName;
    data['price'] = price;
    return data;
  }

  @override
  String toString() {
    return 'LaundryServiceItem{id: $id, itemDescription: $itemDescription, itemName: $itemName, price: $price}';
  }
}

class LaundryServiceResponse implements FromJson<LaundryServiceResponse> {
  int? currentPage;
  List<LaundryServiceItem>? items;
  int? totalItems;
  int? totalPages;

  LaundryServiceResponse({
    this.currentPage,
    this.items,
    this.totalItems,
    this.totalPages,
  });

  @override
  LaundryServiceResponse fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <LaundryServiceItem>[];
      json['items'].forEach((v) {
        items!.add(LaundryServiceItem().fromJson(v));
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
