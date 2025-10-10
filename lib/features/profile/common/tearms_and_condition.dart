import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditonScreen extends StatelessWidget {
  const TermsAndConditonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText("Terms and Condition".tr, size: 18, isBold: true),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: commonText(
          "Lorem ipsum dolor sit amet consectetur. Mauris cursus laoreet ut egestas. Faucibus elit nunc luctus felis. Nullam faucibus quisque tristique elementum sagittis tempus at lectus. Mattis ipsum amet eu aliquam lorem mi scelerisque sodales viverra. Convallis pretium consequat risus ut augue. Parturient at aliquam egestas diam sed. Sagittis et malesuada sem cras. Maecenas eu aliquam id feugiat gravida nisl ultricies. Integer dui odio nibh quis. Faucibus a luctus amet enim lobortis odio. In turpis sed quam sed etiam senectus bibendum in a. Sagittis dui fringilla morbi sit interdum netus. Lacinia nulla at fusce pellentesque elementum suscipit venenatis. Nisl id aliquet quis id sed cursus vel senectus risus. Neque donec aliquet urna dictumst. Tortor semper lorem lacus ipsum commodo. Eget amet urna montes libero enim in semper. Nisi vivamus consectetur euismod ut eget sit ultricies cursus lectus. Nisl cursus fermentum tempor at.",
          size: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}