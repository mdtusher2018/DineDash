import 'package:dine_dash/features/view%20must%20be%20edited/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';
// if needed, import your widget file

class AddDealScreen extends StatefulWidget {
  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reusableAfterController = TextEditingController();
  final TextEditingController maxClaimsController = TextEditingController();
  final TextEditingController dealTitleController = TextEditingController();
  final TextEditingController benefitController=TextEditingController();

  String? selectedBusiness;
  String? selectedDealType;
  String? selectedRefusableDay;
  List<String> businessList = ["Pizza Place", "Cafe", "Dine Hub"];
  List<String> dealTypes = ["1 for 1", "50% Off", "Buy 1 Get 1"];
  List<String> refuesableAfter = ["60 Days", "90 Days"];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  List<TimeFrame> timeFrames = [TimeFrame()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: AppColors.white,
      appBar: commonAppBar(title: "Add Deal".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText(
              "Add a new deal to attract more customers to your restaurant.".tr,
              size: 14,
            ),
            const SizedBox(height: 20),

            commonText("Business*".tr, size: 16, fontWeight: FontWeight.w500),
            SizedBox(height: 8),
            commonDropdown<String>(
              items: businessList,
              value: selectedBusiness,
              hint: "Select your business".tr,
              onChanged: (val) => setState(() => selectedBusiness = val),
            ),
            // const SizedBox(height: 16),
            //          commonTextfieldWithTitle(
            //   "Deal Title*",
            //   dealTitleController,
            //   hintText: "e.g., Happy Hour Special",
              
            // ),
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
                        Icon(
                          Icons.add,
                          size: 18,
                          
                        ),
                        SizedBox(width: 4),
                        commonText(
                          "Add".tr,
                          size: 14,
                          
                        ),
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
                          children: [commonText("Day".tr, size: 14, isBold: true)],
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
                                                  timeFrames[index].startTime !=
                                                          null
                                                      ? timeFrames[index]
                                                          .startTime!
                                                          .format(context)
                                                      : '',
                                            ),
                                            hintText: "Start Time".tr,
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
                                            hintText: "End Time".tr,
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
                        commonText(
                          "* Time frames must be at least 4 hours long".tr,
                          size: 12,
                        ),
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
                      commonDropdown<String>(
                        items: dealTypes,
                        value: selectedDealType,
                        hint: "Deal Type".tr,
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
                        hint: "60 Days",
                        onChanged:
                            (val) => setState(() => selectedRefusableDay = val),
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
              onTap: () {
                Get.back();
              },
              haveNextIcon: false,
            ),SizedBox(height: 24,)
          ],
        ),
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
