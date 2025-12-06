import 'package:dine_dash/features/profile/common/static_content/static_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaticContentController());

    // Fetch "about-us" content on screen load
    controller.fetchStaticContent("about-us");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColors.white,
        title: commonText("About Us".tr, size: 18, isBold: true),
        leading: InkWell(
          onTap: () => Get.close(1),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<String>(
          future: controller.getLocalizedContent(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: commonText(
                  "No content available.".tr,
                  color: Colors.black54,
                  size: 16,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: HtmlWidget(
                snapshot.data!,
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
