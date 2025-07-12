import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:flutter/material.dart';
// Assuming all common widgets are in this file

class AddBusinessScreen extends StatefulWidget {
  @override
  _AddBusinessScreenState createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  // Controllers
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // To hold more items if "Add More Item" is clicked
  List<Map<String, TextEditingController>> itemList = [];

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
      appBar: commonAppBar(title: "Add Business"),
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
            }).toList(),

            // "Add More Item" Button
            commonBorderButton("+ Add More Item", onTap: addMoreItem),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: commonButton(
          "Add Business",
          onTap: () {
            // Implement your business save logic
            print("Business Added!");
          },
        ),
      ),
    );
  }
}
