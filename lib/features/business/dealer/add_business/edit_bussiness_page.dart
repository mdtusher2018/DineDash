import 'dart:io';
import 'package:dine_dash/core/models/dealer_business_model.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/business/dealer/add_business/dealer_business_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/google_location_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditBusinessScreenFrist extends StatefulWidget {
  final String businessId;
  final DealerBusinessModel business;
  const EditBusinessScreenFrist({
    super.key,
    required this.businessId,
    required this.business,
  });
  @override
  _EditBusinessScreenFristState createState() =>
      _EditBusinessScreenFristState();
}

class _EditBusinessScreenFristState extends State<EditBusinessScreenFrist> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final controller = Get.find<DealerAddBusinessController>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  List<String> selectedCategories = [];

  String? selectedBusinessType;

  var selectedLng = Rx<double?>(null), selectedLat = Rx<double?>(null);

  Map<String, bool> closedDays = {
    "Sunday": true,
    "Monday": true,
    "Tuesday": true,
    "Wednesday": true,
    "Thursday": true,
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
  void initState() {
    super.initState();
    businessNameController.text = widget.business.businessName;
    selectedCategories = widget.business.category;
    zipController.text = widget.business.postalCode ?? '';
    addressController.text = widget.business.businessAddress ?? '';
    print('Business Type: ${widget.business.businessType}');
    selectedBusinessType =
        widget.business.businessType != null &&
                (widget.business.businessType == "restaurant" ||
                    widget.business.businessType == "activity")
            ? widget.business.businessType!.substring(0, 1).toUpperCase() +
                widget.business.businessType!.substring(1)
            : null;

    phoneController.text = widget.business.phoneNumber ?? '';
    if (widget.business.openingHours != null) {
      for (final openingModel in widget.business.openingHours!) {
        if (closedDays.containsKey(openingModel.day)) {
          closedDays[openingModel.day] = openingModel.isOpen;

          final openingTimeString = openingModel.openingTime;
          final closingTimeString = openingModel.closingTime;

          // Parse the opening and closing times
          final openingTime = _parseTime(openingTimeString);
          final closingTime = _parseTime(closingTimeString);
          timings[openingModel.day] = TimeOfDayRange(
            start: openingTime,
            end: closingTime,
          );
        }
      }
    }
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(' ');
    final timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    if (parts[1].toUpperCase() == "PM" && hour != 12) {
      hour += 12; // Convert PM time to 24-hour format
    }
    if (parts[1].toUpperCase() == "AM" && hour == 12) {
      hour = 0; // Convert 12 AM to 00 hours
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  /// 📸 Pick image from gallery or camera
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Edit Business"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Basic Information", size: 16, isBold: true),
            const SizedBox(height: 8),

            commonTextfieldWithTitle(
              "Business Name*",
              businessNameController,
              hintText: "Enter your restaurant name",
              enable: false
            ),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
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
            GoogleLocationPicker(
              controller: addressController,
              enable: false,
              onPicked: (lat, lng, address) {
                selectedLat.value = lat;
                selectedLng.value = lng;
                addressController.text = address;
              },
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
              "Save",
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
                            "closingTime": timings[entry.key]!.end.format(
                              context,
                            ),
                          },
                        )
                        .toList();
                await controller.editBusiness(
                  businessId: widget.businessId,
                  name: businessNameController.text.trim(),
                  types: selectedCategories,
                  businessType: selectedBusinessType,

                  address: addressController.text.trim(),
                  phoneNumber: phoneController.text.trim(),
                  postalCode: zipController.text.trim(),
                  openingHours: openingHoursList,
                  coordinates: [selectedLng.value, selectedLat.value],
                  imageFile: _selectedImage,
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({required this.start, required this.end});
}
