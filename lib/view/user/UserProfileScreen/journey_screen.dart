import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 266,
                  width: 266,
                  child: Image.asset("assets/images/journey.png",fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: 20,),
              commonText("Your Journey".tr,size: 26,fontWeight: FontWeight.w700),
              SizedBox(height: 5,),
              commonText("Discovering new restaurants, trying delicious dishes while paying less, a review of your culinary journey!".tr,size: 18,fontWeight: FontWeight.w400,textAlign: TextAlign.center),
              SizedBox(height: 20,),
              Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 11,
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      journeybox(icon: 'assets/images/deals.png', digit: '3', title: 'Deals',),
                      // journeybox(icon: 'assets/images/savings.png', digit: '11 €', title: 'Savings',),
               journeybox(icon: 'assets/images/visited.png', digit: '4', title: 'Visited Place',),
                    ],
                  ),
                  Row(
                    spacing: 11,
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      // journeybox(icon: 'assets/images/visited.png', digit: '4', title: 'Visited Place',),
                      journeybox(icon: 'assets/images/locations.png', digit: '2', title: 'Cities',),
                            journeybox(icon: 'assets/images/star.png', digit: '6', title: 'Ratings',),
                    ],
                  ),
                  Row(
                    spacing: 11,
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      // journeybox(icon: 'assets/images/star.png', digit: '6', title: 'Ratings',),
                      journeybox(icon: 'assets/images/review.png', digit: '1', title: 'Review',),
                      Expanded(child: SizedBox())
                    ],
                  ),

                ],
              ),
              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }
}

class journeybox extends StatelessWidget {
  const journeybox({
    super.key, required this.icon, required this.digit, required this.title,
  });
  final String icon;
  final String digit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffDCE7FA),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child:ClipRect(
                child: Image.asset(icon,height: 22,width: 22,),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(digit,size: 26,fontWeight: FontWeight.w700),
                commonText(title.tr,size: 16,fontWeight: FontWeight.w400,textAlign: TextAlign.start),
              ],
            )
          ],
        ),
      ),
    );
  }
}
