

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BusinessDropdown extends StatelessWidget {


  final List<String> businessList = [
    'All Business names',
    'Others Business names',
  ];

  RxString selectedBusiness = ''.obs;

  BusinessDropdown({super.key});

  void setSelectedBusiness(String value) {
    selectedBusiness.value = value;
  }




  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: selectedBusiness.value.isEmpty
            ? null
            : selectedBusiness.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          hintText: 'Select your business'.tr,
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
        items: businessList.map((business) {
          return DropdownMenuItem<String>(
            value: business,
            child: Text(business),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setSelectedBusiness(value);
          }
        },
      );
    });
  }
}
