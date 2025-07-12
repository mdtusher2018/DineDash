import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../commonWidgets.dart';

class DealerBusinessPage extends StatelessWidget {
  const DealerBusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 64,),
            GestureDetector(
              onTap:(){},
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
                    commonText("Add New Business",size: 18,fontWeight: FontWeight.w500)
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context,index){
                  return  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    height:137,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Container(
                          height: 98,
                          width: 98,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/images/resturant.png",fit: BoxFit.fill,),
                        ),
                        Column(
                          spacing:3,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 55,
                              children: [
                                commonText("Chef's Table",size: 20,fontWeight: FontWeight.w600),
                                Row(
                                  spacing: 10,
                                  children: [
                                    GestureDetector(
                                      onTap: (){},
                                        child: Image.asset("assets/images/editb.png",height: 22,width: 22,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,size: 25,)),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded,size: 25,color: Colors.blueAccent,),
                                commonText("Downtown, 123 Main St",size:16,fontWeight: FontWeight.w400),
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Container(
                                  height: 22,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffB7CDF5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      commonText("2 deals",size: 14,fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 22,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffFFF9C2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      commonText("4.8",size: 14,fontWeight: FontWeight.w400),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        itemSize: 15,
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
                                      commonText("(120)",size: 14,fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            commonText("56 deals redeemed this month",size: 14,fontWeight: FontWeight.w400),
                          ],
                        )
                      ],
                    ),
                  );
                })

          ],
        ),
      ),
    );
  }
}
