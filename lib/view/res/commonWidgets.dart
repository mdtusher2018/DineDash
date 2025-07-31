// ignore_for_file: file_names

import 'package:dine_dash/view/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget commonText(
  String text, {
  double size = 12.0,
  Color color = Colors.black,
  bool isBold = false,
  softwarp,
  maxline = 1000,
  bool haveUnderline = false,
  fontWeight,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text.tr,
    overflow: TextOverflow.ellipsis,
    maxLines: maxline,
    softWrap: softwarp,
    textAlign: textAlign,

    style: TextStyle(
      fontSize: size,
      decoration:
          (haveUnderline) ? TextDecoration.underline : TextDecoration.none,
      color: color,

      fontWeight:
          isBold
              ? FontWeight.bold
              : (fontWeight != null)
              ? fontWeight
              : FontWeight.normal,
    ),
  );
}

Widget commonTextfieldWithTitle(
  String title,
  TextEditingController controller, {
  FocusNode? focusNode,
  String hintText = "",
  bool isBold = false,
  bool issuffixIconVisible = false,
  bool isPasswordVisible = false,
  enable,
  textSize = 14.0,
  suffixIcon,
  borderWidth = 0.0,
  optional = false,
  changePasswordVisibility,
  TextInputType keyboardType = TextInputType.text,
  String? assetIconPath,
  Color borderColor = Colors.grey,
  int maxLine = 1,
  String? Function(String?)? onValidate,
  Function(String?)? onFieldSubmit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonText(title.tr, size: textSize, fontWeight: FontWeight.w500),
          if (optional)
            commonText("(Optional)".tr, size: textSize, color: Colors.grey),
        ],
      ),
      const SizedBox(height: 8),
      Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(
              controller: controller,
              enabled: enable,
              focusNode: focusNode,
              validator: onValidate,
              onFieldSubmitted: onFieldSubmit,
              keyboardType: keyboardType,
              maxLines: maxLine,
              obscureText: isPasswordVisible,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12.0),
                hintText: hintText,
                fillColor: AppColors.white,
                filled: true,
                hintStyle: TextStyle(fontSize: 14, color: AppColors.gray),
                border: InputBorder.none,
                suffixIcon:
                    (issuffixIconVisible)
                        ? (!isPasswordVisible)
                            ? InkWell(
                              onTap: changePasswordVisibility,
                              child: Icon(Icons.visibility),
                            )
                            : InkWell(
                              onTap: changePasswordVisibility,
                              child: Icon(Icons.visibility_off_outlined),
                            )
                        : suffixIcon,
                prefixIcon:
                    assetIconPath != null
                        ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 16,
                            width: 16,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Image.asset(assetIconPath, scale: 2),
                            ),
                          ),
                        )
                        : null,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void navigateToPage(
  Widget page, {
  bool replace = false,
  bool clearStack = false,
  Transition transition = Transition.rightToLeft,
  Duration duration = const Duration(milliseconds: 400),
}) {
  if (clearStack) {
    Get.offAll(page, transition: transition, duration: duration);
  } else if (replace) {
    Get.off(page, transition: transition, duration: duration);
  } else {
    Get.to(page, transition: transition, duration: duration);
  }
}

Widget commonButton(
  String title, {
  Color? color = AppColors.primaryColor,
  Color textColor = Colors.white,
  double textSize = 18,
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  TextAlign textalign = TextAlign.left,
  bool isLoading = false,
  bool haveNextIcon = false,
  double boarderRadious = 16,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(boarderRadious)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonText(
                          textAlign: textalign,
                          title.tr,
                          size: textSize,
                          color: textColor,
                          isBold: true,
                        ),
                        if (haveNextIcon)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.asset("assets/images/arrow.png"),
                          ),
                      ],
                    ),
                  ),
        ),
      ),
    ),
  );
}

Widget commonBorderButton(
  String title, {
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  Color color = AppColors.primaryColor,
  String? imagePath,
  Widget? icon,
  double imageSize = 20.0,
  Color textColor = AppColors.black,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,

      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(1.5), // space for the gradient border
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // inner background color

          borderRadius: BorderRadius.circular(14), // slightly smaller radius
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath,
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
              ],
              if (icon != null) ...[icon, const SizedBox(width: 8)],
              commonText(title.tr, size: 18, color: textColor, isBold: true),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildOTPTextField(
  TextEditingController controller,
  int index,
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(-3, 0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(3, 0),
        ),
      ],
    ),
    width: 55,
    height: 55,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 20),
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1 && index < 5) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}

Widget commonTextField({
  TextEditingController? controller,
  String? hintText,
  TextInputType keyboardType = TextInputType.number,
  void Function(String)? onChanged,
}) {
  return SizedBox(
    width: 50,
    height: 50,
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,

      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText?.tr,
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget commonCheckbox({
  required bool value,
  required Function(bool?) onChanged,
  double textSize = 14,
  String label = '',
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        materialTapTargetSize:
            MaterialTapTargetSize
                .shrinkWrap, // Optional: makes checkbox smaller
        visualDensity: VisualDensity(
          horizontal: -4,
          vertical: -4,
        ), // Reduce extra spacing
        side: const BorderSide(color: Colors.black26),
      ),
      if (label.isNotEmpty) Flexible(child: commonText(label.tr, size: textSize)),
    ],
  );
}

Widget commonDropdown<T>({
  required List<T> items,
  required T? value,
  required String hint,
  required void Function(T?) onChanged,
}) {
  return Material(
    elevation: 1,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        underline: SizedBox(),
        value: value,
        hint: commonText(hint.tr, size: 14),
        items:
            items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: commonText(item.toString(), size: 14),
              );
            }).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

AppBar commonAppBar({
  required String title,
  bool isCenter = true,
  Color backGroundColor = AppColors.white,
  Color textColor = AppColors.black,
  bool hideBackButton = false,
}) {
  return AppBar(
    backgroundColor: backGroundColor,surfaceTintColor: Colors.transparent,
    leading:
        (hideBackButton)
            ? null
            : GestureDetector(
              onTap: () {Get.back();},
              child: Icon(Icons.arrow_back_ios, color: textColor),
            ),
    title: commonText(title.tr, size: 20, isBold: true, color: textColor),
    centerTitle: isCenter,
  );
}
void showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:  commonText(
              "Cancel".tr,
              fontWeight: FontWeight.bold,color: AppColors.black
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
              onDelete(); // Trigger delete action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: commonText("Delete".tr,color: AppColors.white),
          ),
        ],
      );
    },
  );
}
