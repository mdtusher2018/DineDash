// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortByDropdown extends StatelessWidget {

  final RxList<String> shortList = [
    "Newest first",
    "Oldest first",
    "Highest rating",
  ].obs;


  RxString selectedShortBy = ''.obs;

  ShortByDropdown({super.key});


  void setSelectedShortBy(String value) {
    selectedShortBy.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: selectedShortBy.value.isEmpty
            ? null
            : selectedShortBy.value,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          hintText: 'Select your sort'.tr, 
          hintStyle: TextStyle(color: Colors.grey.shade400),
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

        items: shortList.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),

        onChanged: (value) {
          if (value != null) {
            setSelectedShortBy(value); 
          }
        },
      );
    });
  }
}
