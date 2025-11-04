
// ignore_for_file: must_be_immutable

import 'package:dine_dash/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';


import 'package:dine_dash/res/commonWidgets.dart';


class UserAfterGivingStarPage extends StatelessWidget {
   UserAfterGivingStarPage({super.key});

  var selected = ''.obs;
  var selecteds = ''.obs;
  final List<String> options = ['Cafe', 'Juice', 'Bar'];
  final List<String> comment = ['Good environment', 'Perfect meal', 'Nice location'];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(backgroundColor: AppColors.white,leading: BackButton(onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);

      },),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
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
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/images/banner.png",fit: BoxFit.fill,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            commonText("The Rio Lounge",size: 22,fontWeight: FontWeight.w700),
                            SizedBox(height: 5,),
                            Obx(() => Wrap(
                              spacing: 12,
                              children:options.map((option) {
                                final isSelected = selected.value == option;
                                return GestureDetector(
                                  onTap: () {
                                    selected.value = option;
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
                                Expanded(
                                  child: Container(
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
                                          Icon(Icons.location_on_rounded,color: Colors.black,size: 20,),
                                          Flexible(child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: commonText("Direction".tr,size: 16,fontWeight: FontWeight.w600))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: Container(
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
                                          Icon(Icons.share,color: Colors.black,size: 20,),
                                          Flexible(child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: commonText("Share".tr,size: 16,fontWeight: FontWeight.w600))),
                                        ],
                                      ),
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
                                                          commonText("Reusable After".tr,size: 12,fontWeight: FontWeight.w400),
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
                                                          commonText("LOCATION".tr,size: 12,fontWeight: FontWeight.w400),
                                                          commonText("Gulshan 2.",size: 14,fontWeight: FontWeight.w700),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15,),
                                              Container(
                                                height: 50,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFD0DFFF), // light blue background
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  spacing: 10,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    // Blue left semi-circle
                                                    Container(
                                                      width: 20,
                                                      height: 50,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                   commonText("In 50 days bookable again",size:16,fontWeight: FontWeight.w600),
                                                  ],
                                                ),
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
                            Center(child: commonText("Your Ratting".tr,size: 20,fontWeight: FontWeight.w600)),
                            SizedBox(height: 10,),
                            Center(child: RatingBar.builder(
                              initialRating: 3,
                              itemSize: 35,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal:0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),)

                          ],
                        ),
                      ),


                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
