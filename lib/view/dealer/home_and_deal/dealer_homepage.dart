import 'package:dine_dash/view/res/colors.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/dealer/home_and_deal/BusinessDealsPage.dart';
import 'package:dine_dash/view/dealer/home_and_deal/create_deal.dart';
import 'package:dine_dash/view/dealer/notification/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DealerHomepage extends StatelessWidget {
  const DealerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 29,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Hi Dealer!!",size: 18,fontWeight: FontWeight.w700),
                  IconButton(onPressed: (){
                    navigateToPage(DealerNotificationsPage());
                  }, icon: Icon(Icons.notifications_active,color: Colors.orange,)),
                ],
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap:(){
                  navigateToPage(AddDealScreen());
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
                      commonText("Quick Add Deal",size: 18,fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  children: [
                    buildStack(image: 'assets/images/banner1.png', icon: 'assets/images/starreview.png', text: '3', title: 'Total Reviews',),
                    SizedBox(width: 16,),
                    buildStack(image: 'assets/images/banner2.png', icon: 'assets/images/rattingicon.png', text: '4.7', title: 'Avg. Rating',),SizedBox(width: 16,),
                    buildStack(image: 'assets/images/banner3.png', icon: 'assets/images/businesses.png', text: '3', title: 'Businesses',),SizedBox(width: 16,),
                    buildStack(image: 'assets/images/banner4.png', icon: 'assets/images/activedeals.png', text: '8', title: 'Active Deals',),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Image.asset("assets/images/Vector.png",height: 20,width: 30,fit: BoxFit.fill,),
                        commonText("Monthly Performance",size: 16,fontWeight: FontWeight.w500),
                      ],
                    ),
                    commonText("2530",size: 36,fontWeight: FontWeight.w600),
                    commonText("Total monthly deals redeems across all restaurants.",size: 14,fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: commonText("Your Restaurants",size: 18,isBold: true)),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                  physics: ScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context,index){
                return  GestureDetector(
                  onTap: (){
                    navigateToPage(BusinessDealsPage());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    height:117,
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
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/images/resturant.png",fit: BoxFit.fill,),
                        ),
                        Column(
                          spacing:2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Chef's Table",size: 20,fontWeight: FontWeight.w600),
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

class buildStack extends StatelessWidget {
  const buildStack({
    super.key, required this.image, required this.icon, required this.text, required this.title,
  });
  final String image;
  final String icon;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

          ),
          child: Image.asset(image,fit: BoxFit.cover,),
        ),
        Positioned(
          top: 20,
            left: 25,
            right: 25,
            child:Column(
              spacing: 5,
              children: [
                Image.asset(icon,height: 30,width: 30,fit: BoxFit.fill,color: AppColors.black,colorBlendMode: BlendMode.srcIn,),
                commonText(text,size: 26,fontWeight: FontWeight.w700),
                commonText(title,size: 16,fontWeight: FontWeight.w700),
              ],
            ))
      ],
    );
  }
}
