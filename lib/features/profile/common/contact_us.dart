import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/core/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Contact Us".tr),
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 280),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),      Image.asset(ImagePaths.logo),

          SizedBox(height: 16,),
          commonText("If you face any kind of problem with our service feel free to contact us.".tr,size: 16,textAlign: TextAlign.center),
          SizedBox(height: 16,),
          Row(
          
            children: [
              Icon(Icons.call_outlined),SizedBox(width: 8,),
              commonText("(609)327-7992".tr,size: 14)
            ],
          ),
          SizedBox(height: 4),
          Row(
          
            children: [
              Icon(Icons.email_outlined),SizedBox(width: 8,),
              commonText("remeniceenterprise@gmail.com".tr,size: 14)
            ],
          ),
          Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}