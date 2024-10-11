import 'package:limcad/resources/api/from_json.dart';

class LaundryResponse implements FromJson<LaundryResponse> {
  int? currentPage;
  List<LaundryItem>? items;
  int? totalItems;
  int? totalPages;

  LaundryResponse({
    this.currentPage,
    this.items,
    this.totalItems,
    this.totalPages,
  });

  @override
  LaundryResponse fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <LaundryItem>[];
      json['items'].forEach((v) {
        items!.add(LaundryItem.fromJson(v));
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

class LaundryItem {
  String? address;
  String? email;
  int? id;
  double? latitude;
  String? location;
  double? longitude;
  String? name;
  String? phoneNumber;
  LaundryAbout? laundryAbout;
  String? logoPath;
  double? distance;


  LaundryItem({
    this.address,
    this.email,
    this.id,
    this.latitude,
    this.location,
    this.longitude,
    this.name,
    this.phoneNumber,
    this.laundryAbout,
    this.logoPath,
    this.distance,

  });

  factory LaundryItem.fromJson(Map<String, dynamic> json) {
    return LaundryItem(
      address: json['address'],
      email: json['email'],
      id: json['id'],
      latitude: json['latitude'].toDouble(),
      location: json['location'],
      longitude: json['longitude'].toDouble(),
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      laundryAbout: json['laundryAbout'] != null
          ? LaundryAbout.fromJson(json['laundryAbout'])
          : null,
      logoPath: json['logoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['email'] = email;
    data['id'] = id;
    data['latitude'] = latitude;
    data['location'] = location;
    data['longitude'] = longitude;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    if (laundryAbout != null) {
      data['laundryAbout'] = laundryAbout!.toJson();
    }
    data['logoPath'] = logoPath;
    return data;
  }
}

class LaundryAbout {
  String? aboutText;
  String? createdAt;
  int? id;
  String? updatedAt;

  LaundryAbout({
    this.aboutText,
    this.createdAt,
    this.id,
    this.updatedAt,
  });

  factory LaundryAbout.fromJson(Map<String, dynamic> json) {
    return LaundryAbout(
      aboutText: json['aboutText'],
      createdAt: json['createdAt'],
      id: json['id'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aboutText'] = aboutText;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
