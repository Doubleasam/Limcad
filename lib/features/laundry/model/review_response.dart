import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/resources/api/from_json.dart';

class ReviewServiceResponse implements FromJson<ReviewServiceResponse> {
  int? currentPage;
  List<ReviewResponse>? items;
  int? totalItems;
  int? totalPages;

  ReviewServiceResponse(
      {this.currentPage, this.items, this.totalItems, this.totalPages});

  ReviewServiceResponse fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['items'] != null) {
      items = <ReviewResponse>[];
      json['items'].forEach((v) {
        items!.add(new ReviewResponse.fromJson(v));
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

  @override
  String toString() {
    return 'ReviewServiceResponse{currentPage: $currentPage, items: $items, totalItems: $totalItems, totalPages: $totalPages}';
  }
}

class ReviewResponse {
  String? createdAt;
  Customer? customer;
  int? id;
  Organization? organization;
  int? rating;
  String? reviewText;
  String? updatedAt;

  ReviewResponse(
      {this.createdAt,
      this.customer,
      this.id,
      this.organization,
      this.rating,
      this.reviewText,
      this.updatedAt});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    id = json['id'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    rating = json['rating'];
    reviewText = json['reviewText'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['id'] = this.id;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['rating'] = this.rating;
    data['reviewText'] = this.reviewText;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'ReviewResponse{createdAt: $createdAt, customer: $customer, id: $id, organization: $organization, rating: $rating, reviewText: $reviewText, updatedAt: $updatedAt}';
  }
}
