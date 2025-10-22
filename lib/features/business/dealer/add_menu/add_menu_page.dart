import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/business/dealer/add_menu/add_menu_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Assuming all common widgets are in this file

class AddMenuScreen extends StatefulWidget {
  final String businessId;
  const AddMenuScreen({required this.businessId, super.key});

  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  // Controllers
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Map<String, TextEditingController>> itemList = [];
  final controller = Get.find<DealerAddMenuController>();

  @override
  void initState() {
    super.initState();
    itemList.add({
      'name': itemNameController,
      'description': itemDescriptionController,
      'price': priceController,
    });
  }

  void addMoreItem() {
    setState(() {
      itemList.add({
        'name': TextEditingController(),
        'description': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Add Menu"),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Menu", size: 16, isBold: true),
            const SizedBox(height: 16),

            // Dynamically build input fields for each item
            ...itemList.map((item) {
              return Column(
                children: [
                  commonTextfieldWithTitle(
                    "Item Name",
                    item['name']!,
                    hintText: "Enter name",
                  ),
                  const SizedBox(height: 12),
                  commonTextfieldWithTitle(
                    "Item Description",
                    item['description']!,
                    hintText: "Enter a short description",
                  ),
                  const SizedBox(height: 12),
                  commonTextfieldWithTitle(
                    "Price",
                    item['price']!,
                    hintText: "Enter price",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),

            // "Add More Item" Button
            commonBorderButton("+ Add More Item", onTap: addMoreItem),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
           () {
            return commonButton(
              "Add Menu",
              isLoading: controller.isLoading.value,
              onTap: () async {
                final items =
                    itemList.map((item) {
                      return {
                        "itemName": item['name']!.text.trim(),
                        "description": item['description']!.text.trim(),
                        "price": item['price']!.text.trim(),
                      };
                    }).toList();
            
                await controller.addMenuItems(
                  businessId: widget.businessId,
                  items: items,
                );
              },
            );
          }
        ),
      ),
    );
  }
}
