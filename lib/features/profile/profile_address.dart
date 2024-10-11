import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:limcad/config/flavor.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/profile/model/profile_view_model.dart';
import 'package:limcad/resources/models/state_model.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class ProfileAddressPage extends StatefulWidget {
  UserType userType;
  ProfileAddressPage({super.key, required this.userType});
  @override
  _ProfileAddressPageState createState() => _ProfileAddressPageState();
}

class _ProfileAddressPageState extends State<ProfileAddressPage> {
  late ProfileVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileVM>.reactive(
        viewModelBuilder: () => ProfileVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.init(context, ProfileOption.addAddress, widget.userType);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold2(
              showAppBar: true,
              title: 'Address',
              backgroundColor: white,
              body: SingleChildScrollView(
                // If content might overflow
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextFields(
                          controller: model.addressNameController,
                          label: "Address Name",
                          labelText:
                              "Add Name (e.g Home Address, Delivery Address)",
                          showLabel: true,
                          formatter: InputFormatter.stringOnly,
                          maxLines: 1,
                          autocorrect: false,
                          validate: (value) => ValidationUtil.validateText,
                        ).padding(bottom: 16),
                        Text(
                          "Address",
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ).padding(bottom: 6),
                        GooglePlacesAutoCompleteTextFormField(
                            textEditingController: model.addressController,
                            googleAPIKey:
                                FlavorConfig.instance?.values.googleAPIKey ??
                                    "",
                            decoration: InputDecoration(
                                fillColor:
                                    model.addressController?.text.isEmpty ==
                                            true
                                        ? Colors.white
                                        : Colors.transparent,
                                hintText: "Enter Address",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                contentPadding: EdgeInsets.only(left: 27),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 1.0,
                                        color: CustomColors.limcardFaded)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 1.0,
                                        color: CustomColors.limcardFaded)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 1.0,
                                        color: CustomColors.limcardFaded)),
                                labelText: "Address"),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                            // proxyURL: _yourProxyURL,
                            maxLines: 1,
                            overlayContainer: (child) => Material(
                                  elevation: 1.0,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  child: child,
                                ),
                            getPlaceDetailWithLatLng: (prediction) {
                              print('placeDetails${prediction.lng}');
                            },
                            itmClick: (Prediction prediction) {
                              model.addressController.text =
                                  prediction.description ?? "";
                              model.setAddress(prediction);
                            }).padding(bottom: 16),
                        Text(
                          "State",
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ).padding(bottom: 6),
                        DropdownButtonFormField<StateResponse>(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 27),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                          ),
                          style:
                              const TextStyle(color: CustomColors.blackPrimary),
                          icon:
                              const Icon(CupertinoIcons.chevron_down, size: 18)
                                  .padding(right: 16),
                          hint: Text(model.selectedState?.stateName ?? "State",
                              style: TextStyle(
                                  color: CustomColors.smallTextGrey,
                                  fontSize: 14)),
                          borderRadius: BorderRadius.circular(30),
                          items: model.states
                              .map((e) => DropdownMenuItem<StateResponse>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(e.stateName ?? "",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  CustomColors.blackPrimary)),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) => ValidationUtil.validateInput(
                              value?.stateName, "State"),
                          onSaved: (StateResponse? value) =>
                              model.selectedState = value,
                          value: model.selectedState,
                          onChanged: (value) {
                            if (value != null) {
                              model.setStateValue(value);
                            }
                          },
                        ).padding(bottom: 20),
                        Text(
                          "LGA",
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ).padding(bottom: 6),
                        DropdownButtonFormField<LGAResponse>(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 27),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: CustomColors.limcardFaded)),
                          ),
                          style:
                              const TextStyle(color: CustomColors.blackPrimary),
                          icon:
                              const Icon(CupertinoIcons.chevron_down, size: 18)
                                  .padding(right: 16),
                          hint: Text(model.selectedLGA?.lgaName ?? "LGA",
                              style: TextStyle(
                                  color: CustomColors.smallTextGrey,
                                  fontSize: 14)),
                          borderRadius: BorderRadius.circular(30),
                          items: model.lgas
                              .map((e) => DropdownMenuItem<LGAResponse>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(e.lgaName ?? "",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  CustomColors.blackPrimary)),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) => ValidationUtil.validateInput(
                              value?.lgaName, "LGA"),
                          onSaved: (LGAResponse? value) =>
                              model.selectedLGA = value,
                          value: model.selectedLGA,
                          onChanged: (value) {
                            if (value != null) {
                              model.setLGAValue(value);
                            }
                          },
                        ).padding(bottom: 20),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            model.updateUserAddress();
                          },
                          child: const Text("Add Address"),
                        )
                      ],
                    ).padding(bottom: 20),

                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: model.profile?.address?.length,
                        itemBuilder: (context, index) {
                          final address = model.profile?.address?[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${address?.additionalInfo} (${address?.name}) ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withOpacity(0.2),
                                  ),
                                  width: 42,
                                  height: 42,
                                  child: Center(
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "48, Jane Doe Avenue",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           color: black,
                    //           fontWeight: FontWeight.w500),
                    //     ).padding(top: 8),
                    //
                    //     Container(decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.limcadPrimaryLight.withOpacity(0.2)), width: 42, height: 42, child: Center(child: Icon(Icons.delete_outline, color: Colors.red, size: 24, ),),)
                    //   ],
                    // )
                  ],
                ).paddingSymmetric(vertical: 40, horizontal: 16),
              ),
            ));
  }

  // Helper to build sections
  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              ...items,
            ],
          ),
        )
      ],
    );
  }
}
