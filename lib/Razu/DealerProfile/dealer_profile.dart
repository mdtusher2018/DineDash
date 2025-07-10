import 'package:flutter/material.dart';

import '../../commonWidgets.dart';

class DealerProfile extends StatelessWidget {
  const DealerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 74,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Jhon Doi",size: 18,fontWeight: FontWeight.w600),
                        commonText("example.gmail.com",size: 16,fontWeight: FontWeight.w400,color: Color(0xff555555)),
                      ],
                    ),
                    Container(
                      height: 77,
                      width: 77,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/profilepic.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    // Get.to(()=>JourneyScreen());
                  },
                  child: Container(
                    height: 84,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonText("Your Journey",size: 22,fontWeight: FontWeight.w600),
                        SizedBox(width: 50,),
                        Image.asset("assets/images/track.png",height: 66,width: 66,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildcontainer(image: 'assets/images/edit.png', title: 'Edit Profile', onTap: () {},),
                    buildcontainer(image: 'assets/images/setting.png', title: 'Settings', onTap: () {  },),
                    buildcontainer(image: 'assets/images/contact.png', title: 'Contact Us', onTap: () {},),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Divider(thickness: 2,color: Colors.grey.shade300,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildRowCon(image: 'assets/images/policy.png', title: 'Privacy Policy', onTap: () {},),
                buildRowCon(image: 'assets/images/termscon.png', title: 'Terms and Condition', onTap: () {},),
                buildRowCon(image: 'assets/images/about.png', title: 'About Us', onTap: () {},),
                buildRowCon(image: 'assets/images/become.png', title: 'BBack to User', onTap: () {},),
              ],
            ),
          ),
          SizedBox(height: 62,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            decoration: BoxDecoration(
                border: Border(
                  bottom:BorderSide(color: Colors.grey.shade300),
                  top:BorderSide(color: Colors.grey.shade300),)
            ),
            child:Row(
              spacing: 10,
              children: [
                Image.asset("assets/images/logout.png",height: 35,width: 35,fit: BoxFit.fill,),
                commonText("Log Out",size: 16,fontWeight: FontWeight.w600),
              ],
            ),
          )

        ],
      ),
    );
  }
}
class buildRowCon extends StatelessWidget {
  const buildRowCon({
    super.key, required this.image, required this.title, required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Image.asset(image,height: 35,width: 35,fit: BoxFit.fill,),
                commonText(title,size: 16,fontWeight: FontWeight.w600),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey.shade400,size: 25,),
          ],
        ),
      ),
    );
  }
}

class buildcontainer extends StatelessWidget {
  const buildcontainer({
    super.key, required this.image, required this.title, required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 84,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Image.asset(image,height: 35,width: 35,fit: BoxFit.cover,),
            commonText(title,size: 14,fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
