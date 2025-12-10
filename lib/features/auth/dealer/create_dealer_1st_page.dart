// ignore_for_file: use_build_context_synchronously

import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/default_value.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_account_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/google_location_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';

class CreateDealerAccount1stPage extends StatefulWidget {
  const CreateDealerAccount1stPage({super.key});

  @override
  State<CreateDealerAccount1stPage> createState() =>
      _CreateDealerAccount1stPageState();
}

class _CreateDealerAccount1stPageState
    extends State<CreateDealerAccount1stPage> {
  final businessController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  final latitude = RxnDouble();
  final longitude = RxnDouble();

  final controller = Get.find<DealerCreateAccountController>();

  final FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(
    ApiEndpoints.mapKey,
  );

  List<AutocompletePrediction> _businessPredictions = [];
  bool _isPredicting = false;

  // Overlay variables
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _businessFocus = FocusNode();

  final List<PlaceField> _placeFields = [
    PlaceField.Name,
    PlaceField.Address,
    PlaceField.Location,
    PlaceField.PhoneNumber,
    PlaceField.WebsiteUri,
    PlaceField.OpeningHours,
    PlaceField.PhotoMetadatas,
    PlaceField.Rating,
    PlaceField.PriceLevel,
    PlaceField.Types,
    PlaceField.UserRatingsTotal,
    PlaceField.PlusCode,
  ];

  Place? _selectedPlace;

  @override
  void dispose() {
    _businessFocus.dispose();
    businessController.dispose();
    addressController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _showOverlay() {
    _removeOverlay();
    if (_businessPredictions.isEmpty) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: MediaQuery.of(context).size.width - 32,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 60), // adjust height for your TextField
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _businessPredictions.length,
                  itemBuilder: (context, index) {
                    final p = _businessPredictions[index];
                    return InkWell(
                      onTap: () async {
                        final placeDetails = await _places.fetchPlace(
                          p.placeId,
                          fields: _placeFields, // fetch all fields
                        );

                        _selectedPlace = placeDetails.place;

                        businessController.text =
                            placeDetails.place?.name ?? "";
                        addressController.text =
                            placeDetails.place?.address ?? "";
                        latitude.value = placeDetails.place?.latLng?.lat ?? 0.0;
                        longitude.value =
                            placeDetails.place?.latLng?.lng ?? 0.0;

                        _removeOverlay();
                        _businessFocus.unfocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border:
                              index == _businessPredictions.length - 1
                                  ? null
                                  : Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.primaryText,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (p.secondaryText.isNotEmpty)
                                    Text(
                                      p.secondaryText,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: commonText(
          "Register",
          size: 21,
          isBold: true,
          color: AppColors.white,
        ),
        centerTitle: true,
      ),
      bottomSheet: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CompositedTransformTarget(
                    link: _layerLink,
                    child: TextFormField(
                      focusNode: _businessFocus,
                      controller: businessController,
                      decoration: InputDecoration(
                        labelText: "Business Name",
                        hintText: "Search your business",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon:
                            _isPredicting
                                ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                                : const Icon(Icons.search),
                      ),
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          _removeOverlay();
                          setState(() => _businessPredictions = []);
                          return;
                        }
                        setState(() => _isPredicting = true);
                        try {
                          final results = await _places
                              .findAutocompletePredictions(
                                value,
                                placeTypesFilter: [
                                  PlaceTypeFilter.ESTABLISHMENT,
                                ],
                              );
                          setState(() {
                            _businessPredictions = results.predictions;
                            _isPredicting = false;
                          });
                          _showOverlay();
                        } catch (e) {
                          debugPrint("Place prediction error: $e");
                          setState(() => _isPredicting = false);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Address Picker
                  GoogleLocationPicker(
                    label: "Business Detailed Address",
                    controller: addressController,
                    onPicked: (lat, lng, address) {
                      addressController.text = address;
                      longitude.value = lng;
                      latitude.value = lat;
                    },
                  ),

                  const SizedBox(height: 16),

                  commonTextfieldWithTitle(
                    "Your Email",
                    emailController,
                    hintText: "Enter your email",
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    return commonButton(
                      "Next",
                      isLoading: controller.isLoading.value,
                      onTap: () async {
                        await controller.checkEmail(
                          emailController.text,
                          context: context,
                          businessDetails: _selectedPlace,
                          lat: latitude.value ?? DefaultValue.lat,
                          long: longitude.value ?? DefaultValue.lung,
                          address: addressController.text.trim(),
                          businessName: businessController.text.trim(),
                        );
                      },
                    );
                  }),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
