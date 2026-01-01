import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/business/dealer/dealer_business_details/dealer_business_details_response.dart';
import 'package:dine_dash/features/business/dealer/edit_menu/edit_menu_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMenuScreen extends StatefulWidget {
  final MenuItem menu;
  const EditMenuScreen({super.key, required this.menu});

  @override
  _EditMenuScreenState createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  // Controllers
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final controller = Get.find<DealerEditMenuController>();

  @override
  void initState() {
    super.initState();
    itemNameController.text = widget.menu.itemName;
    itemDescriptionController.text = widget.menu.description;
    priceController.text =
        double.parse(widget.menu.price.toStringAsFixed(2)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Edit Price", context: context),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Price", size: 16, isBold: true),
            const SizedBox(height: 16),

            // Dynamically build input fields for each item
            Column(
              children: [
                commonTextfieldWithTitle(
                  "Item Name",
                  itemNameController,
                  hintText: "Enter name",
                ),
                const SizedBox(height: 12),
                commonTextfieldWithTitle(
                  "Item Description",
                  itemDescriptionController,
                  hintText: "Enter a short description",
                ),
                const SizedBox(height: 12),
                commonTextfieldWithTitle(
                  "Price",
                  priceController,
                  hintText: "Enter price",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: commonButton(
          "Save Price",
          onTap: () {
            controller.editMenu(
              context: context,
              menuId: widget.menu.id,
              itemDescription: itemDescriptionController.text,
              itemName: itemNameController.text,
              price: priceController.text,
            );
          },
        ),
      ),
    );
  }
}
