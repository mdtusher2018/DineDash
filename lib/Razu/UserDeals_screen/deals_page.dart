
import 'package:dine_dash/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'deals_details.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 64),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Available Deals",size: 18,fontWeight: FontWeight.w700),
                  commonText("See all",size: 14,fontWeight: FontWeight.w500,color: Color(0xff555555)),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.to(()=>DealsDetails());
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          height: 435,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffE8EFFC)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:134,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset("assets/images/banner.png",fit: BoxFit.fill,),
                              ),
                              SizedBox(height: 6,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonText("The Rio Lounge",size: 14,fontWeight: FontWeight.w600),
                                    Row(
                                      children: [
                                        commonText("Price Range :",size: 14,fontWeight: FontWeight.w600),
                                        commonText(" €50-5000",size: 14,fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 3,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 20,
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
                                        ),
                                        commonText("(120)",size: 14,fontWeight: FontWeight.w500)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        commonText("Open Time :",size: 14,fontWeight: FontWeight.w600),
                                        commonText("9 AM - 10 PM",size: 14,fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 13,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_rounded,color: Colors.blueAccent,),
                                    commonText("Location :",size: 16,fontWeight: FontWeight.w500),
                                    commonText("Gulshan 2, Dhaka.",size: 16,fontWeight: FontWeight.w500),

                                  ],
                                ),
                              ),
                              SizedBox(height: 28,),
                              Divider(thickness: 2,color: Colors.blueAccent,),
                              SizedBox(height: 28,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText("Free cold drinks",size: 20,fontWeight: FontWeight.w600),
                                    commonText("Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",size: 16,fontWeight: FontWeight.w400,color: Color(0xff0A0A0A)),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        SizedBox(width: 30,),
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

                            ],
                          ),
                        ),
                        Positioned(
                            top: 236,
                            left: 145.5,
                            right: 145.5,
                            child:Container(
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
                  ),
                );
              }),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Used Deals",size: 18,fontWeight: FontWeight.w700),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context,index){
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          height: 435,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffE8EFFC)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:134,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset("assets/images/banner.png",fit: BoxFit.fill,),
                              ),
                              SizedBox(height: 6,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonText("The Rio Lounge",size: 14,fontWeight: FontWeight.w600),
                                    Row(
                                      children: [
                                        commonText("Price Range :",size: 14,fontWeight: FontWeight.w600),
                                        commonText(" €50-5000",size: 14,fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 3,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 20,
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
                                        ),
                                        commonText("(120)",size: 14,fontWeight: FontWeight.w500)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        commonText("Open Time :",size: 14,fontWeight: FontWeight.w600),
                                        commonText("9 AM - 10 PM",size: 14,fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 13,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_rounded,color: Colors.blueAccent,),
                                    commonText("Location :",size: 16,fontWeight: FontWeight.w500),
                                    commonText("Gulshan 2, Dhaka.",size: 16,fontWeight: FontWeight.w500),

                                  ],
                                ),
                              ),
                              SizedBox(height: 28,),
                              Divider(thickness: 2,color: Colors.blueAccent,),
                              SizedBox(height: 28,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText("Free cold drinks",size: 20,fontWeight: FontWeight.w600),
                                    commonText("Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",size: 16,fontWeight: FontWeight.w400,color: Color(0xff0A0A0A)),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          spacing: 5,
                                          children: [
                                            Container(
                                              height: 30,
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
                                        SizedBox(width: 30,),
                                        Row(
                                          spacing: 5,
                                          children: [
                                            Container(
                                              height: 30,
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

                            ],
                          ),
                        ),
                        Positioned(
                            top: 236,
                            left: 145.5,
                            right: 145.5,
                            child:Container(
                              height: 39,
                              width: 89,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueAccent
                              ),
                              child: Center(child: commonText("6 € Benefit",size: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                            ))
                      ],
                    );
                  }),

          
            ],
          ),
        ),
      ),
    );
  }
}
