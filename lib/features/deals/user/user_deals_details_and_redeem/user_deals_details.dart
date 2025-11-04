import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/deals/user/model_and_response/deal_model.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deal_redeem.dart';
import 'package:dine_dash/features/deals/user/user_deals_details_and_redeem/user_deal_redeem_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';

class UserDealsDetails extends StatefulWidget {
  final UserDealItem dealData;
  const UserDealsDetails({super.key, required this.dealData});

  @override
  State<UserDealsDetails> createState() => _UserDealsDetailsState();
}

class _UserDealsDetailsState extends State<UserDealsDetails> {
  ShakeDetector? detector;

  var selected = ''.obs;
  var selecteds = ''.obs;

  // final List<String> comment = [
  //   'Good environment',
  //   'Perfect meal',
  //   'Nice location',
  // ];

  final controller = Get.find<UserDealRedeemController>();

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        navigateToPage(
          UserDealRedeemPage(
            businessId: widget.dealData.businessId,
            dealId: widget.dealData.dealId,
            rasturentName: widget.dealData.businessName,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deal = widget.dealData;

    final nextOpening = deal.getNextOpening(); // dealItem is UserDealItem

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffE8E8F5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 124,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/banner.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            commonText(
                              deal.businessName,
                              size: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 5),
                            Obx(
                              () => Wrap(
                                spacing: 12,
                                children:
                                    deal.catgory.map((option) {
                                      final isSelected =
                                          selected.value == option;
                                      return GestureDetector(
                                        onTap: () {
                                          selected.value = option;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? Color(0xffB7CDF6)
                                                    : Color(0xffB7CDF5),
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight:
                                                  isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 31,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: commonText(
                                                "Direction".tr,
                                                size: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    height: 31,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: commonText(
                                                "Share".tr,
                                                size: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xffE8EFFC),
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 17.5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 30),
                                            commonText(
                                              deal.dealType,
                                              size: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            commonText(
                                              deal.description,
                                              size: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff0A0A0A),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              spacing: 5,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    color:
                                                        Colors
                                                            .blueAccent
                                                            .shade100,
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/clock.png",
                                                      height: 25,
                                                      width: 25,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    commonText(
                                                      "Reusable After".tr,
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    commonText(
                                                      "${deal.reuseableAfter} Days",
                                                      size: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  left: 110,
                                  right: 110,
                                  child: Container(
                                    height: 39,
                                    width: 89,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Center(
                                      child: commonText(
                                        "${deal.benefitAmmount} € Benefit",
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 50,
                              children: [
                                Column(
                                  spacing: 10,
                                  children: [
                                    Image.asset(
                                      "assets/images/date.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    commonText(
                                      nextOpening['day']!.tr,
                                      size: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      60, // Adjust this to your desired divider height
                                  child: VerticalDivider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                Column(
                                  spacing: 10,
                                  children: [
                                    Image.asset(
                                      "assets/images/time.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    commonText(
                                      nextOpening['time']!,
                                      size: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: DottedLine(
                                    dashLength: 15,
                                    dashGapLength: 8,
                                    lineThickness: 3,
                                    dashColor: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 48,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Image.asset(
                                    "assets/images/shakephone.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  commonText(
                                    "Shake your phone to redeem".tr,
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            commonButton(
                              "You can redeem from here also".tr,
                              onTap: () async {
                                await controller.dealRedeem(
                                  widget.dealData.id,
                                  businessId: widget.dealData.businessId,
                                  rasturentName: widget.dealData.businessName
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
