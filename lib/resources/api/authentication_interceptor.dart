

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:limcad/config/flavor.dart';
import 'package:limcad/features/auth/models/signup_response.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/response_code.dart';
import 'package:limcad/resources/api/route.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  final APIClient client;

  AuthenticationInterceptor({required this.client});

  Tokens? tokenObject;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authorize = options.extra['Authorize'] ?? false;

    await getToken();

    if (!authorize || tokenObject?.token == null) {
      return super.onRequest(options, handler);
    }

    // bool accessTokenHaveExpired = isExpired(tokenObject?.expiresIn);
    // if (accessTokenHaveExpired) {
    //   //locking makes refreshToken endpoint not to work.
    //   // client.instance.lock();
    //   bool done = await startRefreshToken();
    //   // client.instance.unlock();
    //   if (!done) {
    //     BuildContext context = NavigationService.navigatorKey.currentContext!;
    //     Navigator.pushNamed(context, NewLogin.routeName, arguments: NewLoginModel());
    //     ViewUtil.showSnackbar("Session Expired");
    //     return;
    //   }
    // }

    options.headers['Authorization'] = 'Bearer ${tokenObject!.token}';
    return super.onRequest(options, handler);
  }

  Future<void> getToken() async {
    //var _preference = await UserPreference.getInstance();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var _pref = BasePreference(preferences: preferences);
    tokenObject = _pref.getTokens();
  }

  bool isExpired(DateTime? expiryTime) {
    if (expiryTime != null) {
      return DateTime.now().isAfter(expiryTime);
    }
    return true;
  }

  // Future<bool> startRefreshToken() async {
  //   bool done = false;
  //   String baseUrl = FlavorConfig.instance!.values.baseUrl;
  //   final apiService = APIClient(BaseOptions(baseUrl: baseUrl));
  //   apiService.instance.interceptors.add(LogInterceptor());
  //
  //   await getToken();
  //   // if (tokenObject?.expiresIn != null && tokenObject!.expiresIn!.isAfter(DateTime.now().add(const Duration(minutes: 3)))) {
  //   //   return true;
  //   // }
  //   var response = await apiService.request(
  //       route: ApiRoute(ApiType.refreshToken),
  //       data: RefreshTokenRequest(refreshToken: tokenObject?.refreshToken).toJson(),
  //       create: () => APIResponse<LoginResponse>(create: () => LoginResponse()));
  //   debugPrint("refreshToken endpoint call completed");
  //   if (response.response.status == ResponseCode.ok) {
  //     done = true;
  //     tokenObject = response.response.data;
  //
  //     var _preference = await BasePreference.getInstance();
  //     _preference.saveToken(tokenObject!);
  //   }
  //   return done;
  // }
}
