import 'package:dine_dash/features/view%20must%20be%20edited/dealer/bussiness/edit_bussiness_page.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/dealer/home_and_deal/BusinessDealsPage.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/dealer/bussiness/add_business_screen_frist.dart';
import 'package:dine_dash/features/view%20must%20be%20edited/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../res/commonWidgets.dart';

class DealerBusinessPage extends StatelessWidget {
  const DealerBusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 64,),
            GestureDetector(
              onTap:(){
                navigateToPage(AddBusinessScreenFrist());
              },
              child: Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(Icons.add,size: 28,),
                    Flexible(child: commonText("Add New Business",size: 18,fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                    
                  padding: EdgeInsets.all(0),
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return  GestureDetector(
                      onTap: (){
                               navigateToPage(BusinessDealsPage());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                height: 98,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset("assets/images/resturant.png",fit: BoxFit.fill,),
                              ),
                              Expanded(
                                child: Column(
                                  spacing:3,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,             
                                      children: [
                                        Expanded(child: commonText("Chef's Table",size: 18,fontWeight: FontWeight.w600)),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                navigateToPage(EditBusinessScreenFrist());
                                              },
                                                child: Image.asset("assets/images/editb.png",height: 20,width: 20,)),
                                            IconButton(onPressed: (){
                                                  showDeleteConfirmationDialog(
                                                    context: context,
                                                    title: "Delete Item",
                                                    message: "Are you sure you want to delete this item? This action cannot be undone.",
                                                    onDelete: () {
                                                      // Perform deletion logic here
                                                      print("Item deleted");
                                                    },
                                                  );
                                            }, icon: Image.asset("assets/images/delete.png",width: 18,)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_rounded,size: 25,color: Colors.blueAccent,),
                                        commonText("Downtown, 123 Main St",size:14,fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Color(0xffB7CDF5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              commonText("2 deals",size: 12,fontWeight: FontWeight.w400),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 98,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Color(0xffFFF9C2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              commonText("4.8",size: 12,fontWeight: FontWeight.w400),
                                              RatingBar.builder(
                                                initialRating: 3,
                                                itemSize: 12,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 1,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              commonText("(120)",size: 12,fontWeight: FontWeight.w400),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    commonText("56 deals redeemed this month",size: 14,fontWeight: FontWeight.w400),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )

          ],
        ),
      ),
    );
  }
}
