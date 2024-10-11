import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:limcad/features/dashboard/model/Dashboard_vm.dart';
import 'package:limcad/features/dashboard/widgets/services_widget.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:stacked/stacked.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late DashboardVM model;
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardVM>.reactive(
      viewModelBuilder: () => DashboardVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, UserType.personal).then((_) {
          _updateMapLocation();
        });
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(model.userLatitude, model.userLongitude),
                    zoom: 10,
                  ),
                  markers: model.markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true, // Optional: show the default location button
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                child: GooglePlacesAutoCompleteTextFormField(
                  textEditingController: model.addressController,
                  googleAPIKey: "AIzaSyDmq2C1vmDwUr0cnIAX6djCFspyIHJ5V48",
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Enter Address",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: EdgeInsets.only(left: 27),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded),
                    ),
                  ),
                  getPlaceDetailWithLatLng: (prediction) {
                    setState(() {
                      model.userLatitude = double.tryParse(prediction.lat ?? "0.0") ?? 0.0;
                      model.userLongitude = double.tryParse(prediction.lng ?? "0.0") ?? 0.0;
                    });
                    model.currentLocation = LatLng(model.userLatitude, model.userLongitude);
                    model.fetchOrganisations(); // Fetch organisations based on the new location
                    setState(() {
                      model.markers.clear(); // Clear existing markers
                      model.setMarkersForNearbyServices(); // Update markers for new location
                    _updateMapLocation();
                    });
                  },
                  itmClick: (Prediction prediction) {
                    model.addressController.text = prediction.description ?? "";
                  },
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 230,
                  child: model.laundryOrganisations != null
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.laundryOrganisations!.length,
                    itemBuilder: (_, index) {
                      return ServiceItemWidget(model.laundryOrganisations![index]).paddingAll(8);
                    },
                  )
                      : Center(child: CircularProgressIndicator()), // Show loading indicator if data is being fetched
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to update the map camera position after fetching user location
  void _updateMapLocation() {
    if (model.userLatitude != 0.0 && model.userLongitude != 0.0) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(model.userLatitude, model.userLongitude),
            zoom: 15, // Adjust zoom level as needed
          ),
        ),
      );
    }
  }
}
