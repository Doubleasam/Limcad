import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:limcad/features/auth/services/signup_service.dart';
import 'package:limcad/features/dashboard/dashboard_service.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/api/api_client.dart';
import 'package:limcad/resources/base_vm.dart';
import 'package:limcad/resources/locator.dart';
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show asin, cos, pi, sin, sqrt;



class DashboardVM extends BaseVM {
  final apiService = locator<APIClient>();
  late BuildContext context;
  double userLatitude = 0.0;
  double userLongitude = 0.0;

  String title = "";
  String? email;
  bool isButtonEnabled = false;

  final profile = locator<AuthenticationService>().profile;
  late CameraController controller = CameraController(
      CameraDescription(
          name: 'camera',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 180),
      ResolutionPreset.max);
  var genderList = ["Male", "Female"];

  bool verified = false;


  late BasePreference _preference;
  String? otpId;
  final addressController = TextEditingController();
  String? gender;
  UserType? userType;
  List<LaundryItem>? laundryOrganisations = [];
  LaundryItem? selectedOrganisation;
  final TextEditingController searchController = TextEditingController();
  Set<Marker> markers = {};
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late LatLng currentLocation;
  final GlobalKey fabKey = GlobalKey();

  bool otpSent = false;

  bool isShimmerLoading = false;

  Future<void> init(BuildContext context, [UserType? userT]) async  {
    userType = userT;

    _preference = await BasePreference.getInstance();

    if(userT == UserType.personal){
        await getUserLocation();
      fetchOrganisations();
    }
  }


  Future<void> getUserLocation() async {
    // Check for location permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLatitude = position.latitude;
    userLongitude = position.longitude;
    notifyListeners();
  }



  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of Earth in kilometers
    var dLat = _degToRad(lat2 - lat1);
    var dLon = _degToRad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * asin(sqrt(a));
    return R * c;
  }

  double _degToRad(double deg) {
    return deg * (pi / 180);
  }


  void setMarkersForNearbyServices() {
    markers.clear(); // Clear existing markers
    for (var laundry in laundryOrganisations!) {
      markers.add(Marker(
        markerId: MarkerId(laundry.id.toString()), // Use unique identifier
        position: LatLng(laundry.latitude!, laundry.longitude!),
        infoWindow: InfoWindow(title: laundry.name),
      ));
    }
    notifyListeners(); // Notify listeners to update UI
  }



  void fetchOrganisations() async {
    try {
      isShimmerLoading = true;
      notifyListeners();

      final response = await locator<DashboardService>().getLaundryServices();
      if (response?.data?.items != null && response!.data!.items!.isNotEmpty) {
        laundryOrganisations = response.data!.items!.map((laundry) {
          double distance = calculateDistance(
              userLatitude, userLongitude, laundry.latitude!, laundry.longitude!);
          laundry.distance = distance; // Store the calculated distance in km
          return laundry;
        }).toList();

        // Sort by distance (closest first)
        laundryOrganisations!.sort((a, b) => a.distance!.compareTo(b.distance!));
      } else {
        laundryOrganisations = [];
      }
    } catch (e) {
      Logger().e("Error fetching laundry organisations: $e");
    } finally {
      isShimmerLoading = false;
      notifyListeners();
    }
  }


}
