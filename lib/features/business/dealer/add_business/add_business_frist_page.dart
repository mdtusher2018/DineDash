import 'dart:io';

import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/default_value.dart';
import 'package:dine_dash/features/business/dealer/add_business/dealer_business_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/google_location_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddBusinessScreenFrist extends StatefulWidget {
  const AddBusinessScreenFrist({super.key});

  @override
  _AddBusinessScreenFristState createState() => _AddBusinessScreenFristState();
}

class _AddBusinessScreenFristState extends State<AddBusinessScreenFrist> {

  final TextEditingController addressController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final controller = Get.find<DealerAddBusinessController>();

  final selectedLat = RxnDouble();
  final selectedLng = RxnDouble();

  final businessController = TextEditingController();
  final emailController = TextEditingController();

  final latitude = RxnDouble();
  final longitude = RxnDouble();

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
    PlaceField.AddressComponents,
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

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  List<String> selectedCategories = [];

  String? selectedBusinessType;

  Map<String, bool> closedDays = {
    "Sunday": false,
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": true,
    "Saturday": true,
  };

  Map<String, TimeOfDayRange> timings = {
    for (var day in [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ])
      day: TimeOfDayRange(
        start: const TimeOfDay(hour: 10, minute: 0),
        end: const TimeOfDay(hour: 20, minute: 0),
      ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Add Business"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Basic Information", size: 16, isBold: true),
            const SizedBox(height: 8),

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
                              child: CircularProgressIndicator(strokeWidth: 2),
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
                    final results = await _places.findAutocompletePredictions(
                      value,
                      placeTypesFilter: [PlaceTypeFilter.ESTABLISHMENT],
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

            business2ndPageDetails(),
          ],
        ),
      ),
    );
  }

  Widget business2ndPageDetails() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        commonText("Business Type*", size: 14, fontWeight: FontWeight.w500),
        SizedBox(height: 8),
        commonDropdown<String>(
          items: const ["Restaurant", "Activity"],
          value: selectedBusinessType,
          hint: "Select your business".tr,
          onChanged: (val) {
            setState(() => selectedBusinessType = val);
          },
        ),

        const SizedBox(height: 16),
        if (selectedCategories.isNotEmpty)
          commonText("Categories*", size: 14, fontWeight: FontWeight.w500),
        if (selectedCategories.isNotEmpty) const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              selectedCategories.map((cat) {
                return Chip(
                  label: Text(cat),
                  onDeleted: () {
                    setState(() => selectedCategories.remove(cat));
                  },
                );
              }).toList(),
        ),
        const SizedBox(height: 16),

        commonTextfieldWithTitle(
          "Add Category",
          categoryController,
          hintText: "e.g., Cafe, Bar",
          onchanged: (value) {
            setState(() {});
          },
        ),
        if (categoryController.text.trim().isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (!selectedCategories.contains(
                  categoryController.text.trim(),
                )) {
                  setState(() {
                    selectedCategories.add(categoryController.text.trim());
                    categoryController.clear();
                  });
                } else {
                  Get.snackbar(
                    'Duplicate Category',
                    "This category is already added.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add, size: 18),
                    SizedBox(width: 4),
                    Text("Add"),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),

        /// 📸 Business Image Picker
        commonText("Business Image", size: 14, fontWeight: FontWeight.w500),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: DottedBorder(
            options: const RoundedRectDottedBorderOptions(
              radius: Radius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_selectedImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  else ...[
                    Image.asset("assets/images/Upload.png", width: 30),
                    const SizedBox(height: 12),
                    commonText("Upload your image", size: 16),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        /// 🗺 Location
        commonText("Location", size: 16, isBold: true),
        const SizedBox(height: 8),
        commonTextfieldWithTitle(
          "ZIP/Postal Code*",
          zipController,
          hintText: "e.g., Downtown, Mall District",
        ),

        const SizedBox(height: 16),

        /// ☎ Contact
        commonText("Contact", size: 16, isBold: true),
        const SizedBox(height: 8),
        commonTextfieldWithTitle(
          "Phone Number*",
          phoneController,
          hintText: "+880 126 2548 255",
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 24),

        /// 🕑 Opening Hours
        commonText("Opening Hours", size: 16, isBold: true),
        const SizedBox(height: 12),
        ...[
          "Sunday",
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
        ].map(buildDayRow),

        const SizedBox(height: 24),
        commonButton(
          "Add Business",
          isLoading: controller.isLoading.value,
          onTap: () async {
            final openingHoursList =
                closedDays.entries
                    .where((entry) => !entry.value)
                    .map(
                      (entry) => {
                        "day": entry.key,
                        "openingTime": timings[entry.key]!.start.format(
                          context,
                        ),
                        "closingTime": timings[entry.key]!.end.format(context),
                      },
                    )
                    .toList();

            await controller.createBusiness(
              name: businessController.text.trim(),
              types: selectedCategories,
              businessType: selectedBusinessType,

              address: addressController.text.trim(),
              phoneNumber: phoneController.text.trim(),
              postalCode: zipController.text.trim(),
              openingHours: openingHoursList,
              coordinates: [
                selectedLng.value ?? DefaultValue.lung,
                selectedLat.value ?? DefaultValue.lung,
              ],
              imageFile: _selectedImage,
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildDayRow(String day) {
    final isClosed = closedDays[day]!;
    final hasTime = timings.containsKey(day);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: commonText(day, fontWeight: FontWeight.w600, size: 10),
          ),
          if (hasTime && !isClosed)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: buildTimeBox(
                      timings[day]!.start.format(context),
                      () => pickTime(day: day, isStart: true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  commonText("to"),
                  const SizedBox(width: 8),
                  Expanded(
                    child: buildTimeBox(
                      timings[day]!.end.format(context),
                      () => pickTime(day: day, isStart: false),
                    ),
                  ),
                ],
              ),
            ),
          if (hasTime && isClosed) const Expanded(flex: 3, child: SizedBox()),
          Expanded(
            child: commonCheckbox(
              value: isClosed,
              textSize: 10,
              onChanged:
                  (val) => setState(() => closedDays[day] = val ?? false),
              label: "Closed",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeBox(String time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: commonText(time, size: 10)),
            const Icon(
              Icons.access_time,
              color: AppColors.primaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> pickTime({required String day, required bool isStart}) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? timings[day]!.start : timings[day]!.end,
    );
    if (picked != null) {
      final current = timings[day]!;
      setState(() {
        timings[day] =
            isStart
                ? TimeOfDayRange(start: picked, end: current.end)
                : TimeOfDayRange(start: current.start, end: picked);
      });
    }
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
                        if (_selectedPlace != null) {
                          setState(() {
                            // Name & Address
                            businessController.text =
                                _selectedPlace!.name ?? "";
                            addressController.text =
                                _selectedPlace!.address ?? "";

                            // Phone
                            phoneController.text =
                                _selectedPlace!.phoneNumber ?? "";

                            // Coordinates
                            selectedLat.value =
                                _selectedPlace!.latLng?.lat ?? 0.0;
                            selectedLng.value =
                                _selectedPlace!.latLng?.lng ?? 0.0;

                            if (_selectedPlace?.addressComponents != null) {
                              final pc =
                                  _selectedPlace!.addressComponents!
                                      .firstWhere(
                                        (c) => c.types.contains("postal_code"),
                                      )
                                      .name;
                              if (pc.isNotEmpty) zipController.text = pc;
                            }

                            // Optionally set categories / types from Google Places types
                            selectedCategories =
                                _selectedPlace!.types
                                    ?.map((type) => type.name)
                                    .toList() ??
                                [];

                            // Optional: business type mapping
                            if (_selectedPlace!.types != null &&
                                _selectedPlace!.types!.contains(
                                  PlaceType.RESTAURANT,
                                )) {
                              selectedBusinessType = "Restaurant";
                            } else {
                              selectedBusinessType ??= "Activity";
                            }
                          });
                          if (_selectedPlace!.openingHours?.periods != null) {
                            // Reset closedDays & timings
                            closedDays.updateAll(
                              (key, value) => true,
                            ); // mark all closed by default

                            for (var period
                                in _selectedPlace!.openingHours!.periods) {
                              int dayIndex = period.open.day.index;
                              String dayName =
                                  [
                                    "Sunday",
                                    "Monday",
                                    "Tuesday",
                                    "Wednesday",
                                    "Thursday",
                                    "Friday",
                                    "Saturday",
                                  ][dayIndex];

                              closedDays[dayName] = false;

                              TimeOfDay start = TimeOfDay(
                                hour: period.open.time.hours,
                                minute: period.open.time.minutes,
                              );

                              TimeOfDay end =
                                  period.close != null
                                      ? TimeOfDay(
                                        hour: period.close!.time.hours,
                                        minute: period.close!.time.minutes,
                                      )
                                      : TimeOfDay(
                                        hour: 23,
                                        minute: 59,
                                      ); // assume close at midnight if missing

                              timings[dayName] = TimeOfDayRange(
                                start: start,
                                end: end,
                              );
                            }
                          }
                        }
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
}

class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({required this.start, required this.end});
}
