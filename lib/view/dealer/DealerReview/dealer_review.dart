
import 'package:dine_dash/view/dealer/DealerReview/widget/custom_progress.dart';
import 'package:dine_dash/view/dealer/DealerReview/widget/businessdropdownshow.dart';
import 'package:dine_dash/view/dealer/DealerReview/widget/rattingdropdown.dart';
import 'package:dine_dash/view/dealer/DealerReview/widget/shortbydropdown.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DealerReview extends StatefulWidget {
  const DealerReview({super.key,});

  @override
  State<DealerReview> createState() => _DealerReviewState();
}

class _DealerReviewState extends State<DealerReview> {
  @override
  Widget build(BuildContext context) {


    List ratting=[
      { "ratting": "5.0"},
      { "ratting": "4.0"},
      { "ratting": "3.5"},
      { "ratting": "2.0"},
      { "ratting": "2.5"},
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 64,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("120 ",size: 30,fontWeight: FontWeight.w600),
                      commonText("Total Reviews",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("4.7",size: 30,fontWeight: FontWeight.w600),
                      commonText("Average Rating",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("60",size: 30,fontWeight: FontWeight.w600),
                      commonText("Positive Reviews",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                commonText("Rating Distribution", size: 16, fontWeight: FontWeight.w700),           
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount:ratting.length,
                    itemBuilder: (context, index) {
                      double ratingValue = double.parse(ratting[index]['ratting']);
                      return Row(
                        spacing: 10,
                        children: [
                          commonText("${5 - index}*", size: 20, fontWeight: FontWeight.w500),
                          Expanded(
                            child: RatingProgressBar(rating: ratingValue),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 340,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset("assets/images/filter.png", height: 25, width: 25),
                          SizedBox(width: 5),
                          commonText("Filters", size: 18, fontWeight: FontWeight.w700),
                        ],
                      ),
                      SizedBox(height: 10),
                      commonText("Business", size: 14, fontWeight: FontWeight.w500),
                      SizedBox(height: 10),
                      BusinessDropdown(),
                      SizedBox(height: 10),
                      commonText("Rating", size: 14, fontWeight: FontWeight.w500),
                      SizedBox(height: 10),
                      RattingDropdown(),
                      SizedBox(height: 10),
                      commonText("Sort By", size: 14, fontWeight: FontWeight.w500),
                      SizedBox(height: 10),
                      ShortByDropdown(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16,),
              ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context,index){
                return  Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 194,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/images/profilepic.png",fit: BoxFit.fill,),
                          ),
                          commonText("John Doe",size: 18,fontWeight: FontWeight.w700),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Image.asset("assets/images/noted.png",height:30,width:30,fit: BoxFit.fill,),
                          commonText("The Cafe Rio",size: 14,fontWeight: FontWeight.w500,color: Color(0xff555555)),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            itemSize: 20,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 15,
                            child: VerticalDivider(thickness: 1,color: Colors.grey,),
                          ),
                          commonText("2 days ago",size: 14,fontWeight: FontWeight.w600,color: Color(0xff555555)),
                        ],
                      ),
                      commonText("Amazing food and great service! The happy hour deal was fantastic. Will definitely come back.",size: 14,fontWeight: FontWeight.w500,color: Color(0xff555555)),
                      Container(
                        height: 32,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffB7CDF5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonText("Used :",size: 16,fontWeight: FontWeight.w400),
                            commonText(" Free Drinks",size: 16,fontWeight: FontWeight.w400),
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
