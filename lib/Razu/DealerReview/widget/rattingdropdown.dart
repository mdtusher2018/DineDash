import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/Review_controller/review_controller.dart'; // import controller file

class RattingDropdown extends StatelessWidget {
  final BusinessController controller = Get.put(BusinessController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: controller.selectedRatting.value.isEmpty
            ? null
            : controller.selectedRatting.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          hintText: 'Select your ratting',
          hintStyle: TextStyle(color: Colors.grey.shade100),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        icon: Icon(Icons.arrow_drop_down),
        items: controller.rattingList.map((business) {
          return DropdownMenuItem<String>(
            value: business,
            child: Text(business),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.setSelectedRatting(value);
          }
        },
      );
    });
  }
}
