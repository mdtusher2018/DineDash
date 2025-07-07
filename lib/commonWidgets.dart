import 'package:dine_dash/colors.dart';
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
    text,
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
          commonText(title, size: textSize, fontWeight: FontWeight.w500),
          if (optional)
            commonText("(Optional)", size: textSize, color: Colors.grey),
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
      child: Image.asset(
        assetIconPath,
  scale: 2,
      ),
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
  Color? color=AppColors.primaryColor,
  Color textColor = Colors.white,
  double textSize = 18,
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  TextAlign textalign = TextAlign.left,
  bool isLoading = false,
  bool haveNextIcon = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color:  color,
        
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
                          title,
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

Widget commonSmallButton({
  required String text,
  Color textColor = AppColors.black,
  double radious = 16.0,
  double padding = 16.0,
  ontap,
  Color color = AppColors.yellow,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radious),
      ),
      child: commonText(
        text,
        size: 12.0,
        color: textColor,
        isBold: true,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget commonBorderButton(
  String title, {
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  Color color=AppColors.primaryColor,
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
        color:  Colors.transparent ,
        
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(1.5), // space for the gradient border
      child: Container(
        decoration: BoxDecoration(
          color: color, // inner background color
          border: Border.all(width: 2,color: color),
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
              commonText(title, size: 18, color: textColor, isBold: true),
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

Widget commonRadioGroup(
  String group,
  List<String> values,
  String selectedValue,

  Function(String) onChanged, {
  int crossAxisCount = 2,
  bool alignCenter = false,
  double childRatio = 4.0,
  Map<String, Widget>? conditionalWidgets, // <-- NEW
}) {
  final showExtra = (String val) {
    return conditionalWidgets != null && conditionalWidgets.containsKey(val);
  };

  if (crossAxisCount == 1) {
    return Column(
      children:
          values.map((val) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: val,
                      groupValue: selectedValue,
                      onChanged: (newVal) => onChanged(newVal!),
                      activeColor: AppColors.yellow,
                    ),
                    Flexible(child: commonText(val, size: 14)),
                  ],
                ),
                if (selectedValue == val && showExtra(val))
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 12),
                    child: conditionalWidgets![val]!,
                  ),
              ],
            );
          }).toList(),
    );
  }

  if (alignCenter) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children:
          values.map((val) {
            return IntrinsicWidth(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: val,
                    groupValue: selectedValue,
                    onChanged: (newVal) => onChanged(newVal!),
                    activeColor: AppColors.yellow,
                  ),
                  Flexible(child: commonText(val, size: 14)),
                ],
              ),
            );
          }).toList(),
    );
  }

  return GridView.count(
    crossAxisCount: crossAxisCount,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: childRatio,
    children:
        values.map((val) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: val,
                  groupValue: selectedValue,
                  onChanged: (newVal) => onChanged(newVal!),
                  activeColor: AppColors.yellow,
                ),
                Flexible(child: commonText(val, size: 14)),
              ],
            ),
          );
        }).toList(),
  );
}

Widget commonNumberInputField({
  required String hintText,
  required int value,
  required TextEditingController controller,
  required Function(int) onChanged,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (text) {
              final parsed = int.tryParse(text);
              if (parsed != null) {
                onChanged(parsed);
              }
            },
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: const Icon(Icons.keyboard_arrow_up),
              onTap: () {
                final current = int.tryParse(controller.text) ?? 0;
                final updated = current + 1;
                controller.text = updated.toString();
                onChanged(updated);
              },
            ),
            InkWell(
              child: const Icon(Icons.keyboard_arrow_down),
              onTap: () {
                final current = int.tryParse(controller.text) ?? 0;
                if (current > 0) {
                  final updated = current - 1;
                  controller.text = updated.toString();
                  onChanged(updated);
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget commonRadioGroupWithWidgetsOnly({
  required String selectedValue,
  required List<Widget> widgets, // Widgets with text/row layout
  required Function(String) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(widgets.length, (index) {
      final val = index.toString(); // use index as unique string value
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<String>(
                value: val,
                groupValue: selectedValue,
                onChanged: (newVal) => onChanged(newVal!),
                activeColor: AppColors.yellow,
              ),
              Expanded(child: widgets[index]),
            ],
          ),
        ],
      );
    }),
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
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
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
  String label = '',
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Colors.black26),
      ),
      if (label.isNotEmpty) Flexible(child: commonText(label, size: 14)),
    ],
  );
}

Widget commonDropdown<T>({
  required List<T> items,
  required T? value,
  required String hint,
  required void Function(T?) onChanged,
}) {
  return Container(
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
      hint: commonText(hint, size: 14),
      items:
          items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: commonText(item.toString(), size: 14),
            );
          }).toList(),
      onChanged: onChanged,
    ),
  );
}



AppBar commonAppBar({required String title,bool isCenter=true,Color backGroundColor=AppColors.white,Color textColor=AppColors.black,bool hideBackButton=false}){
  return AppBar(
    backgroundColor: backGroundColor,
    leading: (hideBackButton)?null: InkWell(
    onTap: ()=>Get.back(),
    child: Icon(Icons.arrow_back_ios,color: textColor,)),
    title: commonText(title,size: 20,isBold: true,color: textColor),
    centerTitle: isCenter,
  );
}