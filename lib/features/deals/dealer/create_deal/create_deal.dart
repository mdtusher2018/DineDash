// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/models/my_business_name_response.dart';
import 'package:dine_dash/features/deals/dealer/create_deal/create_deal_controller.dart';
import 'package:dine_dash/features/deals/dealer/create_deal/deal_type_response.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';
// if needed, import your widget file

class AddDealScreen extends StatefulWidget {
  DealerBusinessItem? selectedBusiness;
  AddDealScreen({this.selectedBusiness, super.key});
  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  final TextEditingController descriptionController = TextEditingController(
    text: (kDebugMode) ? "Ride boooom boom" : null,
  );
  final TextEditingController maxClaimsController = TextEditingController(
    text: kDebugMode ? "100" : null,
  );
  final TextEditingController benefitController = TextEditingController(
    text: kDebugMode ? "20" : null,
  );

  DealerBusinessItem? selectedBusiness;
  DealType? selectedDealType;
  // String? selectedDealType;
  String? selectedRefusableDay;
  List<String> refuesableAfter = ["60 Days", "90 Days"];
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    'Saturday',
    'Sunday',
  ];
  List<TimeFrame> timeFrames = [TimeFrame()];

  final controller = Get.find<DealerCreateDealController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllBusinessesName();
      controller.featchAllDealType();
      if (widget.selectedBusiness != null) {
        selectedBusiness = widget.selectedBusiness;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: commonAppBar(title: "Add Deal".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.businessesName.isEmpty && controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(
                "Add a new deal to attract more customers to your restaurant."
                    .tr,
                size: 14,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(
                    "Business*".tr,
                    size: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  if (controller.businessesName.isEmpty &&
                      !controller.isLoading.value)
                    InkWell(
                      onTap: controller.fetchAllBusinessesName,
                      child: commonText("Reload"),
                    ),
                ],
              ),
              SizedBox(height: 8),
              if (widget.selectedBusiness != null)
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextFormField(
                        controller: TextEditingController(
                          text: widget.selectedBusiness!.businessName,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          fillColor: Colors.white,
                          filled: true,
                          enabled: false,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

              if (widget.selectedBusiness == null)
                commonDropdown<DealerBusinessItem>(
                  items: controller.businessesName,
                  value: selectedBusiness,
                  hint: "Select your business".tr,
                  labelBuilder: (p0) => p0.businessName,
                  onChanged: (val) => setState(() => selectedBusiness = val),
                ),

              const SizedBox(height: 30),

              /// Description
              commonTextfieldWithTitle(
                "Description",
                descriptionController,
                hintText: "Describe your deal...".tr,
                maxLine: 3,
              ),
              const SizedBox(height: 16),

              /// Time Frames Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(
                    "Active Time Frames*".tr,
                    size: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        timeFrames.add(TimeFrame());
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 18),
                          SizedBox(width: 4),
                          commonText("Add".tr, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Time Frame Widgets
              ...List.generate(timeFrames.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          if (timeFrames.length > 1)
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeFrames.removeAt(index);
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    commonText(
                                      "Remove".tr,
                                      size: 14,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              commonText("Day".tr, size: 14, isBold: true),
                            ],
                          ),
                          SizedBox(height: 8),
                          commonDropdown<String>(
                            items: days,
                            value: timeFrames[index].day,
                            hint: "Select day".tr,
                            onChanged: (val) {
                              setState(() {
                                timeFrames[index].day = val;
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          /// Start & End Time
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap:
                                                () => _pickTime(
                                                  context,
                                                  true,
                                                  index,
                                                ),
                                            child: commonTextfieldWithTitle(
                                              "Start Time".tr,
                                              TextEditingController(
                                                text:
                                                    timeFrames[index]
                                                                .startTime !=
                                                            null
                                                        ? timeFrames[index]
                                                            .startTime!
                                                            .format(context)
                                                        : '',
                                              ),
                                              hintText: "Start Time".tr,
                                              enable: false,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap:
                                                () => _pickTime(
                                                  context,
                                                  false,
                                                  index,
                                                ),
                                            child: commonTextfieldWithTitle(
                                              "End Time".tr,
                                              TextEditingController(
                                                text:
                                                    timeFrames[index].endTime !=
                                                            null
                                                        ? timeFrames[index]
                                                            .endTime!
                                                            .format(context)
                                                        : '',
                                              ),
                                              enable: false,
                                              hintText: "End Time".tr,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          // commonText(
                          //   "* Time frames must be at least 4 hours long".tr,
                          //   size: 12,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),

              /// Max Claims
              commonTextfieldWithTitle(
                "Benefit Amount*".tr,
                benefitController,
                hintText: "e.g. 100",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(
                          "Deal Type*".tr,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8),
                        commonDropdown<DealType>(
                          items: controller.dealTypes,
                          value: selectedDealType,
                          hint: "Select your deal type".tr,
                          labelBuilder: (p0) => p0.name,
                          onChanged:
                              (val) => setState(() => selectedDealType = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(
                          "Reusable After*".tr,
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8),
                        commonDropdown<String>(
                          items: refuesableAfter,
                          value: selectedRefusableDay,
                          hint: "Reusable After",
                          onChanged:
                              (val) =>
                                  setState(() => selectedRefusableDay = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Max Claims
              commonTextfieldWithTitle(
                "Maximum Claims*".tr,
                maxClaimsController,
                hintText: "e.g. 100".tr,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),

              /// Create Deal Button
              commonButton(
                "Create Deal".tr,
                isLoading: controller.isLoading.value,
                onTap: () {
                  final formattedActiveTimes =
                      timeFrames
                          .where(
                            (t) =>
                                t.day != null &&
                                t.startTime != null &&
                                t.endTime != null,
                          )
                          .map(
                            (t) => {
                              "day": t.day,
                              "startTime":
                                  "${t.startTime!.hour.toString().padLeft(2, '0')}:${t.startTime!.minute.toString().padLeft(2, '0')}",
                              "endTime":
                                  "${t.endTime!.hour.toString().padLeft(2, '0')}:${t.endTime!.minute.toString().padLeft(2, '0')}",
                            },
                          )
                          .toList();

                  controller.createDeal(
                    context: context,
                    business: selectedBusiness,
                    description: descriptionController.text.trim(),
                    benefitAmount:
                        double.tryParse(benefitController.text.trim()) ?? 0,
                    dealType: selectedDealType?.name ?? "",
                    reusableAfter:
                        int.tryParse(
                          selectedRefusableDay?.split(' ').first ?? "0",
                        ) ??
                        0,
                    maxClaimCount:
                        int.tryParse(maxClaimsController.text.trim()) ?? 0,
                    activeTime: formattedActiveTimes,
                  );
                },
                haveNextIcon: false,
              ),

              SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }

  Future<void> _pickTime(BuildContext context, bool isStart, int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          timeFrames[index].startTime = picked;
        } else {
          timeFrames[index].endTime = picked;
        }
      });
    }
  }
}

class TimeFrame {
  String? day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  TimeFrame({this.day, this.startTime, this.endTime});
}
