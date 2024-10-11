import 'package:dio/dio.dart';

enum ApiType {
  registerUser,
  requestEmailOtp,
  validateEmailOtp,
  changePassword,
  states,
  lgas,
  login,
  profile,
  laundyAbout,
  postLaundryAbout,
  changeLaundrAbout,
  passwordResetCodeRequest,
  passwordReset,
  createUserWallet,
  getUserWallet,
  laundyServiceItems,
  laundries,
  createLaundryServiceItems,
  updateProfile,
  updateOrganization,
  submitOrder,
  laundyOrders,
  businessLaundryOrders,
  businessOnboarding,
  businessProfile,
  businessOrders,
  businessOrdersDetails,
  updateBusinessOrdersDetails,
  uploadFile,
  getFile,
  submitReview,
  getReview,
  ordersItems,
  giftCard,
  deleteServiceItems,
  updateServiceItems,
  courier,
}

class ApiRoute implements APIRouteConfigurable {
  final ApiType type;
  final String? routeParams;
  final Map<String, dynamic>? data;
  final headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  ApiRoute(this.type, {this.routeParams, this.data});

  @override
  RequestOptions? getConfig() {
    final authorize = {'Authorize': true};

    switch (type) {
      //register
      case ApiType.registerUser:
        return RequestOptions(
            path: '/users/registration', method: ApiMethod.post, data: data);

      case ApiType.login:
        return RequestOptions(
            path: '/auth/login', method: ApiMethod.post, data: data);

      //
      //states
      case ApiType.states:
        return RequestOptions(
            path: '/states?$routeParams', method: ApiMethod.get);

      case ApiType.profile:
        return RequestOptions(
            path: '/users/profile', method: ApiMethod.get, extra: authorize);

      //lgas
      case ApiType.lgas:
        return RequestOptions(
            path: '/lgas/$routeParams', method: ApiMethod.get);

      //requestOtp
      case ApiType.requestEmailOtp:
        return RequestOptions(
            path: '/auth/email-verification-code-request',
            method: ApiMethod.post,
            data: data);

      case ApiType.validateEmailOtp:
        return RequestOptions(
            path: '/auth/email-verification',
            method: ApiMethod.post,
            data: data,
            extra: authorize);

      case ApiType.changePassword:
        return RequestOptions(
            path: '/auth/password-reset', method: ApiMethod.post, data: data);

      case ApiType.submitOrder:
        return RequestOptions(
            path: '/laundry-orders?$routeParams',
            method: ApiMethod.post,
            data: data,
            extra: authorize);

      case ApiType.laundyAbout:
        return RequestOptions(
            path: '/laundry-about/organizations/$routeParams',
            method: ApiMethod.get);

      case ApiType.postLaundryAbout:
        return RequestOptions(
            path: '/laundry-about',
            method: ApiMethod.post,
            data: data,
            extra: authorize);

      case ApiType.changeLaundrAbout:
        return RequestOptions(
            path: '/laundry-about',
            method: ApiMethod.put,
            data: data,
            extra: authorize);

      case ApiType.passwordResetCodeRequest:
        return RequestOptions(
            path: '/auth/password-reset-code-request',
            method: ApiMethod.post,
            data: data);

      case ApiType.passwordReset:
        return RequestOptions(
            path: "/auth/password-reset", method: ApiMethod.post, data: data);

      case ApiType.createUserWallet:
        return RequestOptions(
            path: '/customer-wallets/$routeParams',
            method: ApiMethod.post,
            extra: authorize);

      case ApiType.getUserWallet:
        return RequestOptions(
            path: '/customer-wallets/$routeParams',
            method: ApiMethod.get,
            extra: authorize);

      case ApiType.laundyServiceItems:
        return RequestOptions(
            path: '/laundry-service-items?$routeParams',
            method: ApiMethod.get,
            extra: authorize);

      case ApiType.laundries:
        return RequestOptions(
            path: '/organizations?$routeParams',
            method: ApiMethod.get,
            extra: authorize);

      case ApiType.createLaundryServiceItems:
        return RequestOptions(
            path: '/laundry-service-items',
            method: ApiMethod.post,
            data: data,
            extra: authorize);

      case ApiType.laundyOrders:
        return RequestOptions(
            path: '/laundry-orders?$routeParams',
            method: ApiMethod.get,
            extra: authorize);

      case ApiType.businessLaundryOrders:
        return RequestOptions(
            path: '/laundry-orders/$routeParams',
            method: ApiMethod.get,
            extra: authorize);

      case ApiType.updateProfile:
        return RequestOptions(
            path: '/users',
            method: ApiMethod.patch,
            data: data,
            extra: authorize);
      case ApiType.updateOrganization:
        return RequestOptions(
            path: '/organizations',
            method: ApiMethod.patch,
            data: data,
            extra: authorize);
      case ApiType.courier:
        return RequestOptions(
            path: '/couriers/registration',
            method: ApiMethod.post,
            data: data,
            extra: authorize);
      case ApiType.businessOnboarding:
        return RequestOptions(
            path: "/business/onboard",
            method: ApiMethod.post,
            data: data,
            extra: authorize);
      case ApiType.businessProfile:
        return RequestOptions(
            path: "/business/staff/profile",
            method: ApiMethod.get,
            extra: authorize);
      case ApiType.businessOrders:
        return RequestOptions(
          path: "/order-items",
          method: ApiMethod.get,
          extra: authorize,
        );
      case ApiType.ordersItems:
        return RequestOptions(
          path: "/order-items/$routeParams",
          method: ApiMethod.get,
          extra: authorize,
        );
      case ApiType.businessOrdersDetails:
        return RequestOptions(
          path: "/laundry-orders/$routeParams",
          method: ApiMethod.get,
          extra: authorize,
        );
      case ApiType.updateBusinessOrdersDetails:
        return RequestOptions(
          path: "/laundry-orders/$routeParams",
          method: ApiMethod.put,
          extra: authorize,
          data: data,
        );
      case ApiType.uploadFile:
        return RequestOptions(
            path: "/organization-images",
            method: ApiMethod.post,
            data: data,
            extra: authorize,
            headers: {"Content-Type": "multipart/form-data"});
      case ApiType.getFile:
        return RequestOptions(
          path: "/images/organization/$routeParams",
          method: ApiMethod.get,
          extra: authorize,
        );
      case ApiType.submitReview:
        return RequestOptions(
          path: "/organization-reviews",
          method: ApiMethod.post,
          extra: authorize,
          data: data,
        );
      case ApiType.getReview:
        return RequestOptions(
          path: "/organization-reviews/organization/$routeParams",
          method: ApiMethod.get,
          extra: authorize,
        );
      case ApiType.giftCard:
        return RequestOptions(
            path: '/gift-cards/create',
            method: ApiMethod.post,
            extra: authorize,
            data: data);
      case ApiType.deleteServiceItems:
        return RequestOptions(
          path: "/laundry-service-items/$routeParams",
          method: ApiMethod.delete,
          extra: authorize,
        );
      case ApiType.updateServiceItems:
        return RequestOptions(
          path: "/laundry-service-items/$routeParams",
          method: ApiMethod.patch,
          data: data,
          extra: authorize,
        );
      default:
        return null;
    }
  }
}

abstract class APIRouteConfigurable {
  RequestOptions? getConfig();
}

class ApiMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}
