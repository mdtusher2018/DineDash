import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/dealer/bussiness/add_new_bussiness.dart';
import 'package:flutter/material.dart';

class AddBusinessScreenFrist extends StatefulWidget {
  @override
  _AddBusinessScreenFristState createState() => _AddBusinessScreenFristState();
}

class _AddBusinessScreenFristState extends State<AddBusinessScreenFrist> {
  // Controllers
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<String> selectedCategories = ['Cafe', 'Juice', 'Bar'];
  final List<String> allCategories = ['Cafe', 'Juice', 'Bar', 'Diner'];
  String? selecteategory;


  Map<String, bool> closedDays = {
    "Sunday": true,
    "Monday": true,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
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
        end: const TimeOfDay(hour: 22, minute: 0),
      ),
  };

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
          if (hasTime && isClosed) Expanded(flex: 3, child: SizedBox()),

          Expanded(
            child: commonCheckbox(
              value: isClosed,
              textSize: 10,
              onChanged: (val) {
                setState(() => closedDays[day] = val ?? false);
              },
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
      appBar: commonAppBar(title: "Add Business"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Basic Information",size: 16,isBold: true),
            SizedBox(height: 8,),
            // Business Name
            commonTextfieldWithTitle(
              "Business Name*",
              businessNameController,
              hintText: "Enter your restaurant name",
            ),
            const SizedBox(height: 16),

            // Categories
            commonText("Categories*", size: 14, fontWeight: FontWeight.w500),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  selectedCategories
                      .map(
                        (cat) => Chip(
                          label: Text(cat),
                          onDeleted: () {
                            setState(() {
                              selectedCategories.remove(cat);
                            });
                          },
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 16),
                 commonDropdown<String>(
              items: allCategories,
              value: selecteategory,
              hint: "Select your business",
              onChanged: (val){
 setState(() {
              selecteategory = val;
            });
              },
            ),
          if (selecteategory != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                       if (!selectedCategories.contains(selecteategory)) {
            setState(() {
              selectedCategories.add(selecteategory!);
              selecteategory = null; // Reset dropdown
            });
                            }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  margin: EdgeInsets.symmetric(vertical: 8),
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
                        "Add",
                        size: 14,
                        
                      ),
                    ],
                  ),
                ),
              ),
            ),SizedBox(height: 8,),
             commonText("Location",size: 16,isBold: true),
            SizedBox(height: 8,),
            commonTextfieldWithTitle(
              "ZIP/Postal Code*",
              zipController,
              hintText: "e.g., Downtown, Mall District",
            ),
            const SizedBox(height: 16),

            // Location - Detailed
            commonTextfieldWithTitle(
              "Detailed Address*",
              addressController,
              hintText: "e.g., 123 Main Street, Building Name",
            ),
            const SizedBox(height: 16),

             commonText("Contact",size: 16,isBold: true),
            SizedBox(height: 8,),
            commonTextfieldWithTitle(
              "Phone Number*",
              phoneController,
              hintText: "+880 126 2548 255",
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),

            // Opening Hours
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

            // Submit Button
            commonButton(
              "Next",
              onTap: () {
                navigateToPage(AddBusiness2ndScreen());
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
