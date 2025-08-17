
import 'package:dine_dash/view/user/deals/ratting_page.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/deal_details_controller/deal_details_controller.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DealDetailsController controller = Get.put(DealDetailsController());
    // TextEditingController commentController=TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              commonText( "How was your experience at?".trParams(
    {'restaurantName': "The Rio Lounge"}
  ),size: 22,fontWeight: FontWeight.w700),
              SizedBox(height: 50,),
     
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText("Rating:".tr,size: 18,fontWeight: FontWeight.w700),
                    RatingBar.builder(
                      initialRating: 3,
                      itemSize: 25,
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
                  ],
                ),
              ),
              SizedBox(child: Divider(height: 1,color: Colors.grey,)),
              SizedBox(height: 20,),
              commonText("Comment:".tr,size: 18,fontWeight: FontWeight.w600),
              SizedBox(height: 10,),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Let others know about your experience..".tr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Obx(() => Wrap(
                spacing: 12,
                children:controller.comment.map((option) {
                  final isSelected = controller.selecteds.value == option;
                  return GestureDetector(
                    onTap: () {
                      controller.selecteds.value = option;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      margin: EdgeInsets.symmetric(vertical: 5),
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
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
              SizedBox(height: 170,),
              commonButton("Continue".tr,onTap: (){
                Get.to(()=> RattingPage());
              }),
              SizedBox(height: 10,),
              Center(child: TextButton(onPressed: (){}, child:commonText("Remind me later".tr,size: 18,fontWeight: FontWeight.w600))),
              SizedBox(height: 20,),

            ],
          ),
      ),
      )
    );
  }
}
