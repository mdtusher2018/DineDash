

import 'package:dine_dash/view/user/deals/reminder_screen.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/deal_details_controller/deal_details_controller.dart';


class DealsDetails extends StatelessWidget {
  const DealsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DealDetailsController controller = Get.put(DealDetailsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffE8E8F5),
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 124,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/banner.png",fit: BoxFit.fill,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            commonText("The Rio Lounge",size: 22,fontWeight: FontWeight.w700),
                            SizedBox(height: 5,),
                            Obx(() => Wrap(
                              spacing: 12,
                              children:controller.options.map((option) {
                                final isSelected = controller.selected.value == option;
                                return GestureDetector(
                                  onTap: () {
                                    controller.selected.value = option;
                                  },
                                  child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Color(0xffB7CDF6)
                                          : Color(0xffB7CDF5),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 31,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on_rounded,color: Colors.black,size: 22,),
                                        commonText("Direction",size: 16,fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 31,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.share,color: Colors.black,size: 22,),
                                        commonText("Share",size: 16,fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xffE8EFFC),
                                        border: Border.all(color: Colors.blueAccent)
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 17.5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 30,),
                                            commonText("Free cold drinks",size: 20,fontWeight: FontWeight.w600),
                                            commonText("Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",size: 16,fontWeight: FontWeight.w400,color: Color(0xff0A0A0A)),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 5,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.blueAccent.shade100
                                                      ),
                                                      child: Center(child: Image.asset("assets/images/clock.png",height: 25,width: 25,fit: BoxFit.contain,)),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        commonText("Reusable After",size: 12,fontWeight: FontWeight.w400),
                                                        commonText("60 Days",size: 14,fontWeight: FontWeight.w700),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  spacing: 5,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.blueAccent.shade100
                                                      ),
                                                      child: Center(child: Image.asset("assets/images/locate.png",height: 25,width: 25,fit: BoxFit.contain,)),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        commonText("LOCATION",size: 12,fontWeight: FontWeight.w400),
                                                        commonText("Gulshan 2.",size: 14,fontWeight: FontWeight.w700),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
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
                                      color: Colors.blueAccent
                                  ),
                                  child: Center(child: commonText("6 € Benefit",size: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                                ))
                              ],
                            ),
                            SizedBox(height: 16,),
                            commonText("Lorem ipsum dolor sit amet consectetur. Amet Rhoncus molestie amet non pellentesque. Amet Rhoncus molestie amet non.",size: 16,fontWeight: FontWeight.w400),
                           SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 50,
                              children: [
                                Column(
                                  spacing: 10,
                                  children: [
                                    Image.asset("assets/images/date.png",height: 30,width: 30,),
                                    commonText("Saturday",size: 16,fontWeight: FontWeight.w500),
                                  ],
                                ),
                                SizedBox(
                                  height: 60, // Adjust this to your desired divider height
                                  child: VerticalDivider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                Column(
                                  spacing: 10,
                                  children: [
                                    Image.asset("assets/images/time.png",height: 30,width: 30,),
                                    commonText("12:00 - 20:00",size: 16,fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: DottedLine(
                                  dashLength:15,
                                  dashGapLength: 8,
                                  lineThickness: 3,
                                  dashColor: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 48,
                                width:double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blueAccent)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Image.asset("assets/images/shakephone.png",height: 30,width: 30,fit: BoxFit.cover,),
                                    commonText("Shake your phone to redeem",size: 18,fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            commonButton("You can redeem from here also",onTap: (){
                              Get.to(() => ReminderScreen());
                            }),



                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
