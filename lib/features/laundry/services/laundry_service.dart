import 'dart:io';
import 'dart:typed_data';

import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/laundry/model/about_response.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/business_orders.dart';
import 'package:limcad/features/laundry/model/file_response.dart';
import 'package:limcad/features/laundry/model/laundry_order_response.dart';
import 'package:limcad/features/laundry/model/laundry_orders_response.dart';
import 'package:limcad/features/laundry/model/laundry_service_response.dart';
import 'package:limcad/features/laundry/model/order_items_response.dart';
import 'package:limcad/features/laundry/model/review_response.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/route.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/models/no_object_response.dart';
import 'package:limcad/resources/models/profile.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:path/path.dart' as p;
import '../../../resources/api/base_response.dart';

class LaundryService with ListenableServiceMixin {
  final apiService = locator<APIClient>();

  Future<AboutResponse?> getAbout(int id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.laundyAbout, routeParams: "${id}"),
        create: () =>
            BaseResponse<AboutResponse>(create: () => AboutResponse()));
    return response.response.data;
  }

  Future<BaseResponse<LaundryServiceResponse>?> getLaundryServiceItems(int? id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.laundyServiceItems,
            routeParams: "organizationId=$id&page=0&size=10"),
        create: () => BaseResponse<LaundryServiceResponse>(
            create: () => LaundryServiceResponse()));
    return response.response;
  }


  Future<BaseResponse<LaundryServiceResponse>> getLaundryServiceItemsProfile(
      int orgId, int page, int size) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.laundyServiceItems,
            routeParams: "organizationId=$orgId&page=$page&size=$size"),
        create: () => BaseResponse<LaundryServiceResponse>(
            create: () => LaundryServiceResponse()));
    return response.response;
  }

  Future<BaseResponse<LaundryServiceItem>> createServiceItems(
      String name, String desc, double price) async {
    final request = {"itemName": name, "itemDescription": desc, "price": price};
    var response = await apiService.request(
        route: ApiRoute(ApiType.createLaundryServiceItems),
        data: request,
        create: () => BaseResponse<LaundryServiceItem>(
            create: () => LaundryServiceItem()));
    return response.response;
  }

  Future<BaseResponse<LaundryServiceItem>> updateServiceItems(
      int id, LaundryServiceItem item) async {
    final request = {
      "itemName": item.itemName,
      "itemDescription": item.itemDescription,
      "price": item.price
    };
    var response = await apiService.request(
        route: ApiRoute(ApiType.updateServiceItems, routeParams: "$id"),
        data: request,
        create: () => BaseResponse<LaundryServiceItem>(
            create: () => LaundryServiceItem()));
    return response.response;
  }

  Future<BaseResponse<NoObjectResponse>> deleteServiceItems(int id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.deleteServiceItems, routeParams: "$id"),
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return response.response;
  }

  Future<BaseResponse<LaundryOrders>?> getLaundryOrders() async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.laundyOrders,  routeParams: "page=0&size=40"),
        create: () =>
            BaseResponse<LaundryOrders>(create: () => LaundryOrders()));
    return response.response;
  }

  Future<BaseResponse<BusinessLaundryOrders>?> getBusinessLaundryOrders() async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.businessLaundryOrders, routeParams: "details?page=0&size=30&userType=BUSINESS"),
        create: () =>
            BaseResponse<BusinessLaundryOrders>(create: () => BusinessLaundryOrders()));
    return response.response;
  }

  Future<BaseResponse<NoObjectResponse>> addAboutUs(String aboutUs) async {
    final request = {"aboutText": aboutUs};
    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.postLaundryAbout),
        data: request,
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return loginResponse.response;
  }

  Future<BaseResponse<NoObjectResponse>> editAboutUs(String aboutUs) async {
    final request = {"aboutText": aboutUs};
    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.changeLaundrAbout),
        data: request,
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return loginResponse.response;
  }

  Future<BaseResponse<NoObjectResponse>> submitOrder(
      Map<String, dynamic> orderItemJson,
      int? organizationId,
      String? pickupDate,
      ProfileResponse? profile) async {
    // BasePreference basePreference = await BasePreference.getInstance();

    // var profileResponse = await locator<AuthenticationService>().getProfile();
    final orderRequest = {
      "organizationId": organizationId,
      "orderDetails": // Use a list instead of a set
          orderItemJson,
      "deliveryDetails": {
        "addressId": profile?.address?[0].id,
        "pickupDate": pickupDate
      }
    };
// 4,9,11
    // print("Order Request: ${profileResponse.toString()}");

    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.submitOrder, routeParams: "paymentMode=ONLINE"),
        data: orderRequest,
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return loginResponse.response;
  }

  Future<BaseResponse<LaundryOrderResponse>> getBusinessOrder() async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.businessOrders),
        create: () => BaseResponse<LaundryOrderResponse>(
            create: () => LaundryOrderResponse()));

    return response.response;
  }

  Future<BusinessOrderDetailResponse?> getBusinessOrderDetail(int id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.businessOrdersDetails, routeParams: "$id"),
        create: () => BaseResponse<BusinessOrderDetailResponse>(
            create: () => BusinessOrderDetailResponse()));
    return response.response.data;
  }


  Future<OrderItemsResponse?> getOrderDetailItems(int id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.ordersItems,  routeParams: "$id?page=0&size=10"),
        create: () => BaseResponse<OrderItemsResponse>(
            create: () => OrderItemsResponse()));
    return response.response.data;
  }

  Future<BaseResponse<BusinessOrderDetailResponse>> updateStatus(
      int id, String status) async {
    var request = {"status": status};
    var response = await apiService.request(
        route:
            ApiRoute(ApiType.updateBusinessOrdersDetails, routeParams: "$id"),
        data: request,
        create: () => BaseResponse<BusinessOrderDetailResponse>(
            create: () => BusinessOrderDetailResponse()));
    return response.response;
  }

  Future<BaseResponse<NoObjectResponse>> uploadFile(File file) async {
    final request = {
      "file": p.basename(file.path),
      "type": determineFileType(file)
    };
    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.uploadFile),
        data: request,
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return loginResponse.response;
  }

  Future<BaseAPIListResponse<FileResponse>> getFile(int? id) async {
    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.getFile, routeParams: "$id"),
        create: () => BaseAPIListResponse<FileResponse>(create: () => FileResponse()));
    return loginResponse.response;
  }

  Future<BaseResponse<NoObjectResponse>> submitReview(
      int star, int? id, String text) async {
    final request = {"organizationId": id, "rating": star, "reviewText": text};
    var loginResponse = await apiService.request(
        route: ApiRoute(ApiType.submitReview),
        data: request,
        create: () =>
            BaseResponse<NoObjectResponse>(create: () => NoObjectResponse()));
    return loginResponse.response;
  }

  Future<BaseResponse<ReviewServiceResponse>> getReview(int? id) async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.getReview, routeParams: "$id?page=0&size=10"),
        create: () => BaseResponse<ReviewServiceResponse>(
            create: () => ReviewServiceResponse()));
    return response.response;
  }

  static String determineFileType(File file) {
    String extension = p.extension(file.path);

    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.pdf':
        return 'application/pdf';
      case '.txt':
        return 'text/plain';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      default:
        return 'application/octet-stream'; // Generic fallback
    }
  }
}
