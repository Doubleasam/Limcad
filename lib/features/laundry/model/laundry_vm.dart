import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/components/payment_web_page.dart';
import 'package:limcad/features/laundry/model/about_response.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/business_orders.dart';
import 'package:limcad/features/laundry/model/file_response.dart';
import 'package:limcad/features/laundry/model/laundry_order_response.dart';
import 'package:limcad/features/laundry/model/laundry_orders_response.dart';
import 'package:limcad/features/laundry/model/laundry_service_response.dart';
import 'package:limcad/features/laundry/model/order_items_response.dart';
import 'package:limcad/features/laundry/model/review_response.dart';
import 'package:limcad/features/laundry/services/laundry_service.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/api/response_code.dart';
import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/galley_widget.dart';
import 'package:limcad/resources/widgets/view_utils/view_utils.dart';
import 'package:logger/logger.dart';

enum LaundryOption {
  about,
  selectClothe,
  review,
  sendReview,
  orders,
  order_details,
  businessOrder,
  businessOrderDetails,
  image,
  services
}

enum OrderStatus {
  PENDING,
  PAYMENT_CONFIRMED,
  ORDER_ASSIGNED,
  ORDER_DECLINED,
  ORDER_PICKED_UP,
  ORDER_DELIVERED,
  IN_PROGRESS,
  COMPLETED,
  FAILED,
  CANCELLED,
  DECLINED,
}

extension OrderStatusExtension on OrderStatus {
  String get displayValue {
    switch (this) {
      case OrderStatus.PENDING:
        return 'Pending';
      case OrderStatus.PAYMENT_CONFIRMED:
        return 'Payment Confirmed';
      case OrderStatus.ORDER_ASSIGNED:
        return 'Order Assigned';
      case OrderStatus.ORDER_DECLINED:
        return 'Order Declined';
      case OrderStatus.ORDER_PICKED_UP:
        return 'Order Picked Up';
      case OrderStatus.ORDER_DELIVERED:
        return 'Order Delivered';
      case OrderStatus.IN_PROGRESS:
        return 'In Progress';
      case OrderStatus.COMPLETED:
        return 'Completed';
      case OrderStatus.FAILED:
        return 'Failed';
      case OrderStatus.CANCELLED:
        return 'Cancelled';
      case OrderStatus.DECLINED:
        return 'Declined';
      default:
        return '';
    }
  }
}

class LaundryVM extends BaseVM {
  final apiService = locator<APIClient>();
  final laundryService = locator<LaundryService>();
  late BuildContext context;
  String title = "";
  final instructionController = TextEditingController();
  final aboutUsController = TextEditingController();
  final pickupDateController = TextEditingController();
  bool isPreview = false;
  bool isButtonEnabled = false;

  AboutResponse? laundryAbout;
  LaundryOption? laundryOption;
  List<LaundryServiceItem>? laundryServiceItems = [];
  List<LaundryOrderItem>? laundryOrderItems = [];
  List<LaundryOrder>? businessLaundryOrderItems = [];
  List<OrderItem>? orderItems = [];

  List<ReviewResponse>? reviews = [];
  LaundryOrders? laundryOrders;
  BusinessLaundryOrders? businessLaundryOrders;
  LaundryServiceResponse? laundryServiceResponse;
  Map<LaundryServiceItem, num> selectedItems = {};
  BusinessOrderDetailResponse? businessOrderDetails;
  List<GuideLinesModel> imgList = [];
  List<FileResponse?> fileResponse = [];
  int selectedIndex = 0;
  LaundryItem? laundry;
  OrderStatus orderStatus = OrderStatus.PENDING;
  double totalPrice = 0.0;
  XFile? _selectedFile;

  String? checkoutUrl;
  XFile? get selectedFile => _selectedFile;
  final ImagePicker picker = ImagePicker();
  double ratingValue = 0;
  final profile = locator<AuthenticationService>().profile;
  bool hasUsedAboutUs = false;
  int? orderId;
  String? pickupDate;
  late BasePreference _preference;
  String? paymentReference;
  String? extractedCode;


  void init(BuildContext context, LaundryOption laundryOpt, [LaundryItem? laundry, int? orderId]) async {
    this.context = context;
    this.laundryOption = laundryOpt;
    if(laundry != null){
      this.laundry = laundry;
    }
    if(orderId != null){
      this.orderId = orderId;
    }

    if (laundryOpt == LaundryOption.selectClothe) {
      getLaundryItems();
    }

    if (laundryOpt == LaundryOption.order_details) {
      getOrderDetail(orderId!);
      getOrderDetailItems(orderId!);
    }

    if (laundryOpt == LaundryOption.orders) {
      getOrders();
    }

    if (laundryOpt == LaundryOption.services) {
      final preferences = await BasePreference.getInstance();
      final value = preferences.getBusinessLoginDetails();

      if (value!.id != null) {
        getLaundryItemsProfile(value.id!, 0, 10);
      }
    }

    if (laundryOpt == LaundryOption.businessOrder) {
      getBusinessOrders();
    }

    if (laundryOpt == LaundryOption.businessOrderDetails) {
      if (this.orderId != null) {
        getOrderDetail(this.orderId!);
        getOrderDetailItems(this.orderId!);
      }
    }

    if (laundryOpt == LaundryOption.review) {
      getReview();
    }

    if (laundryOpt == LaundryOption.image) {
      fetchImage();
    }
    _preference = await BasePreference.getInstance();

  }

  Future<bool> hasAddedAnAboutUs() async {
    final preferences = await BasePreference.getInstance();
    return preferences.getHasAddedAnAboutUs();
  }

  void updateSelectedItem(LaundryServiceItem item, num quantity) {
    if (quantity > 0) {
      selectedItems[item] = quantity;
    } else {
      selectedItems.remove(item);
    }
    notifyListeners();
  }

  void proceed() {
    isPreview = true;
    notifyListeners();
  }

  double calculateTotalPrice() {
    double total = 0.0;
    selectedItems.forEach((item, quantity) {
      total += (item.price ?? 0.0) * quantity;
    });
    return total;
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> pickFileFromGallery() async {
    _selectedFile = await picker.pickImage(source: ImageSource.gallery);
    await uploadFile(_selectedFile);
    notifyListeners();
  }

  Future<UploadedFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path;
      if (filePath != null) {
        return UploadedFile(
          fileName: result.files.single.name,
          file: File(filePath),
        );
      }
    }
    return null;
  }

  Future<void> selectAndUploadFile() async {
    UploadedFile? uploadedFile = await pickFile();
    if (uploadedFile != null) {
      print('File selected: ${uploadedFile.fileName}');
    } else {
      print('No file selected');
    }
  }

  Future<void> submitReview(BusinessOrderDetailResponse? businessOrderDetailsid) async {
   isLoading(true);
    final response = await locator<LaundryService>().submitReview(
        ratingValue.toInt(), businessOrderDetailsid?.organization?.id, instructionController.text);
    if (response.status == 200) {
      reviewOrder();
    }
   isLoading(false);
  }

  void reviewOrder() {
    ViewUtil.showDynamicDialogWithButton(
        barrierDismissible: false,
        context: context,
        titlePresent: false,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                AssetUtil.successCheck,
                width: 64,
                height: 64,
              ).padding(bottom: 24, top: 22),
            ),
            const Text(
              "Review submitted",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CustomColors.kBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  height: 1.2),
            ).padding(bottom: 16),
            const Text(
              "Your review has been successfully submitted.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CustomColors.kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.2),
            ).padding(bottom: 24)
          ],
        ),
        buttonText: "Continue",
        dialogAction1: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }

  Map<String, dynamic> generateOrderJson() {
    // Generate the order details based on the selected items
    List<Map<String, dynamic>> itemsJson = selectedItems.entries.map((entry) {
      return {
        "itemId": entry.key.id,
        "quantity": entry.value.toInt(),
      };
    }).toList();

    return {
      "items": itemsJson,
    };
  }

  Future<void> proceedToPay() async {
    isLoading(true); // Indicate the loading state
    Map<String, dynamic> orderJson = generateOrderJson(); // Generate order JSON

    final dio = Dio(); // Create a Dio instance

    // Prepare the request data
    final orderRequest = {
      "organizationId": laundry?.id,
      "orderDetails": orderJson,
      "deliveryDetails": {
        "addressId": profile?.address?[0].id,
        "pickupDate": pickupDate,
      },
    };

    // Retrieve the Bearer token (replace with your actual token retrieval logic)
    String bearerToken = _preference.getTokens()?.token ?? "";

    try {
      // Log the request data
      Logger().i("Sending request to the server: ${jsonEncode(orderRequest)}");

      final response = await dio.post(
        'http://167.71.185.95/api/laundry-orders?paymentMode=ONLINE',
        data: orderRequest,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );

      // Log the raw response
      Logger().i("Response received: ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
        if (response.data is String) {
          checkoutUrl = response.data;
          Logger().i("Checkout URL: $checkoutUrl");

          if (checkoutUrl!.isNotEmpty) {
            extractedCode = ViewUtil.extractCodeFromUrl(checkoutUrl!);
            showPaymentSheet(
              header: 'Payment to ${laundry?.name}',
              url: Uri.encodeFull( checkoutUrl!),
            );
          }
        } else if (response.data is Map<String, dynamic>) {
          ViewUtil.showSnackBar(response.data['message'], true);
        } else {
          ViewUtil.showSnackBar("Unexpected response format", true);
        }
      } else {
        // Handle non-200 responses
        Logger().i("Non-200 response: ${response.statusMessage}");
        ViewUtil.showSnackBar(response.statusMessage ?? "An Error Occurred", true);
      }
    } catch (e) {
      // Handle exceptions, including Dio-specific ones
      if (e is DioException) {
        Logger().e("DioException occurred: ${e.response?.data}");
        ViewUtil.showSnackBar("An Error Occurred: ${e.message}", true);
      } else {
        Logger().e("General exception occurred: $e");
        ViewUtil.showSnackBar("An Error Occurred", true);
      }
    } finally {
      isLoading(false); // Reset the loading state
    }
  }



  showPaymentSheet({required String url, required String header}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => PaymentWebPage(
        url: url,
        header: header, onConfirmPayment: (String paymentRef) {
        paymentReference = paymentRef;
        Logger().i(paymentRef);
        notifyListeners();
      },
      ),
    );
  }







  Future<void> getLaundryItems() async {
    isLoading(true);
    final response = await locator<LaundryService>().getLaundryServiceItems(laundry?.id);
    laundryServiceResponse = response?.data;
    if (laundryServiceResponse!.items!.isNotEmpty) {
      laundryServiceItems?.addAll(laundryServiceResponse!.items?.toList() ?? []);
      Logger().i(response?.data);
    }
    isLoading(false);
    notifyListeners();
  }

  Future<void> getOrders() async {
    isLoading(true);
    final response = await locator<LaundryService>().getLaundryOrders();
    laundryOrders = response?.data;
    if (laundryOrders!.items!.isNotEmpty) {
      laundryOrderItems?.addAll(laundryOrders!.items?.reversed.toList() ?? []);
      Logger().i(response?.data);
    }
    isLoading(false);
    notifyListeners();
  }

  Future<void> getBusinessOrders() async {
    isLoading(true);
    final response = await locator<LaundryService>().getBusinessLaundryOrders();
    businessLaundryOrders = response?.data;
    if (businessLaundryOrders!.items!.isNotEmpty) {
      businessLaundryOrderItems?.addAll(businessLaundryOrders!.items?.reversed.toList() ?? []);
      Logger().i(response?.data);
    }
    isLoading(false);
    notifyListeners();
  }

  Future<void> getOrderDetail(int id) async {
    isLoading(true);
    final response = await locator<LaundryService>().getBusinessOrderDetail(id);
    businessOrderDetails = response;

    print("print: ${businessOrderDetails.toString()}");
    Logger().i(response);
    totalPrice = businessOrderDetails?.amountPaid ?? 0.0;
    isLoading(false);
    notifyListeners();
  }


  Future<void> getOrderDetailItems(int id) async {
    isLoading(true);
    final response = await locator<LaundryService>().getOrderDetailItems(id);
    orderItems = response?.items ?? [];
    Logger().i(response?.items);
    isLoading(false);
    notifyListeners();
  }

  Future<void> getReview() async {
    print("Getting Review");
    isLoading(true);
    final response = await locator<LaundryService>().getReview(laundry?.id);
    if (response.status == 200) {
      print("response is: ${response.data.toString()}");
      if (response.data!.items!.isNotEmpty) {
        reviews?.addAll(response.data!.items ?? []);
      }
      Logger().i(response.data);
    }
    isLoading(false);
    notifyListeners();
  }



  Future<void> updateStatus(OrderStatus status, BusinessOrderDetailResponse? businessOrderDetails) async {
    final response = await locator<LaundryService>()
        .updateStatus(businessOrderDetails?.id ?? 0, status.toString().split(".").last);
    if (response.status == 200 || response.status == 201) {
      ViewUtil.showSnackBar("Updated Successfully", false);
      this.businessOrderDetails = response.data;
      getOrderDetail(businessOrderDetails!.id!);
      getOrderDetailItems(businessOrderDetails!.id!);
      notifyListeners();
    }
  }

  void setStatus(OrderStatus status) {
    orderStatus = status;
    notifyListeners();
  }

  Future<void> uploadFile(XFile? filename) async {
    if (filename != null) {
      final file = File(filename.path);
      final response = await locator<LaundryService>().uploadFile(file);
      if (response.status == 200) {
        ViewUtil.showSnackBar("Updated Successfully", false);
      }
    }
  }

  Future<void> fetchImage() async {
    BasePreference basePreference = await BasePreference.getInstance();
    final profileResponse = basePreference.getProfileDetails();
    if (profileResponse?.id != null) {
      final response =
          await locator<LaundryService>().getFile(laundry?.id);
      if (response.status == 200) {
        if (response.data != null) {
          List<FileResponse> files = [];
          for (var element in (response.data as List)) {
            files.add(element as FileResponse);
          }
          if(files.isNotEmpty){
           fileResponse = files;
           imgList = getGalleryImgList(fileResponse);
           notifyListeners();
          }
        }

      }
    }
  }

// ================================================================= About Us Functions
  Future<void> getLaundryAbout(int id) async {
    isLoading(true);
    laundryAbout = await laundryService.getAbout(id);

    if (laundryAbout?.aboutText != null) {
      aboutUsController.text = laundryAbout!.aboutText!;
      hasUsedAboutUs = true;
    } else {
      aboutUsController.text = '';
      hasUsedAboutUs = false;
    }
    isLoading(false);
    notifyListeners();
  }

  Future<void> addLaundryAbout(String aboutUs) async {
    isLoading(true);
    if (aboutUs.isNotEmpty) {
      final response = await laundryService.addAboutUs(aboutUs);
      if (response.status == 200) {
        Logger().i(response.data);
      }
    }
    isLoading(false);
  }

  Future<void> editLaundryAbout(String aboutUs) async {
    isLoading(true);
    if (aboutUs.isNotEmpty) {
      final response = await laundryService.editAboutUs(aboutUs);
      if (response.status == 200) {
        Logger().i(response.data);
      }
    }
    isLoading(false);
  }

  //---------------------------------------------------------------- Create Service

  Future<void> createServiceItem(String name, String desc, double price) async {
    try {
      isLoading(true);
      final response =
          await laundryService.createServiceItems(name, desc, price);
      if (response.status == 200 && response.data != null) {
        Logger().i(response.data);
        if (laundryServiceItems != null) {
          laundryServiceItems!.add(response.data!);
        }
        isLoading(false);
        notifyListeners();
      } else {
        isLoading(false);
        Logger().e('Failed to create service item. Status: ${response.status}');
      }
    } catch (e) {
      isLoading(false);
      Logger().e('Error creating service item: $e');
    }
  }

  Future<void> getLaundryItemsProfile(int orgId, int page, int size) async {
    isLoading(true);
    final response = await locator<LaundryService>()
        .getLaundryServiceItemsProfile(orgId, page, size);
    laundryServiceResponse = response.data;
    if (laundryServiceResponse!.items!.isNotEmpty) {
      laundryServiceItems
          ?.addAll(laundryServiceResponse!.items?.toList() ?? []);
      Logger().i(response.data);
    }
    isLoading(false);
    notifyListeners();
  }

  Future<void> deleteLaundryItems(int id) async {
    final response = await locator<LaundryService>().deleteServiceItems(id);
    if (response.status == 200) {
      laundryServiceItems?.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  Future<void> editLaundryItems(int id, LaundryServiceItem item) async {
    Logger().i(item.toString());
    isLoading(true);
    final response =
        await locator<LaundryService>().updateServiceItems(id, item);
    if (response.status == 200) {
      laundryServiceItems?.removeWhere((element) => element.id == id);
      laundryServiceItems?.add(response.data!);
      Logger().i(response.data);
      isLoading(false);
      notifyListeners();
    }
  }

  List<GuideLinesModel> getGalleryImgList(List<FileResponse?> fileResponse) {
    List<GuideLinesModel> list = [];

    for (FileResponse? file in fileResponse) {
      GuideLinesModel model = GuideLinesModel();
      model.img = file?.path ?? "assets/images/placeholder.jpg";
      list.add(model);
    }

    return list;
  }
}

class UploadedFile {
  File file; // The actual file object
  String fileName;

  UploadedFile({
    required this.file,
    required this.fileName,
  });
}
