import 'dart:io';
import 'dart:typed_data';

import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/model/about_response.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/file_response.dart';
import 'package:limcad/features/laundry/model/laundry_order_response.dart';
import 'package:limcad/features/laundry/model/laundry_orders_response.dart';
import 'package:limcad/features/laundry/model/laundry_service_response.dart';
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

class DashboardService with ListenableServiceMixin {
  final apiService = locator<APIClient>();



  Future<BaseResponse<LaundryResponse>?> getLaundryServices() async {
    var response = await apiService.request(
        route: ApiRoute(ApiType.laundries,
            routeParams: "page=0&size=20"),
        create: () => BaseResponse<LaundryResponse>(
            create: () => LaundryResponse()));
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
