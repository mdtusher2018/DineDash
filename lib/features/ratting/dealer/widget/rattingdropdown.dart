// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RattingDropdown extends StatelessWidget {

  final List<String> rattingList = [
   " All Stars",
   " 5 Stars",
    "4 Stars",
   " 3 Stars",
   " 2 Stars",
    "1 Stars"
  ];


  RxString selectedRatting = ''.obs;


  RattingDropdown({super.key});


  void setSelectedRatting(String value) {
    selectedRatting.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: selectedRatting.value.isEmpty
            ? null
            : selectedRatting.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          hintText: 'Select your ratting'.tr,
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
        items: rattingList.map((business) {
          return DropdownMenuItem<String>(
            value: business,
            child: Text(business),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setSelectedRatting(value);
          }
        },
      );
    });
  }
}
