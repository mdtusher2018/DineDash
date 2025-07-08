import 'package:flutter/material.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/colors.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  
  int selectedTabIndex = 0;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
Image.network(
                    "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                       Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
      ],),
   
      bottomSheet: SizedBox(

        height: MediaQuery.sizeOf(context).height*0.65,
        child: Column(
          children: [
       
        
            /// Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  /// Handle Indicator
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
        
                  /// Title, Tags, Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: commonText("The Rio Lounge", size: 18, isBold: true),
                      ),
                      Row(
                        children: [
                          Icon(Icons.workspace_premium, color: Colors.amber),
                          SizedBox(width: 4),
                          commonText("5.0", size: 14), SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          commonText("(120)", size: 12, color: Colors.grey),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
        
                  Wrap(
                    spacing: 8,
                    children: ["Cafe", "Juice", "Bar"]
                        .map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),

                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(10)

                          ),
                              child: commonText(tag),
                              
                              
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
        
                  Row(
                    children:  [
                      Icon(Icons.location_on, size: 16, color: AppColors.primaryColor),
                      SizedBox(width: 4),
                      commonText("Gulshan 2, Dhaka. ",size: 14),
                      commonText("(2.2 km)",size: 14),
                      Spacer(),
                      commonText("€€€€",color: Colors.red,isBold: true,size: 14),
                      Spacer(),
                    ],
                  ),
        
                  const SizedBox(height: 12),
        
                  /// Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Image.asset("assets/images/menu.png"),
                          label: commonText("Menu",isBold: true,size: 14),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                          onPressed: () {}, icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.black
                                
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Icon(Icons.favorite_border))),
                      IconButton(
                          onPressed: () {}, icon: Container(
                            
                               padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.black
                                
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Icon(Icons.share_outlined))),
                    ],
                  ),
        
                  const SizedBox(height: 12),
        
                  /// Closed banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.circle, size: 10, color: Colors.red),
                        const SizedBox(width: 8),
                        commonText("Currently Closed",
                            color: Colors.red, isBold: true),
                        Spacer(),
                        Icon(Icons.access_time, color: Colors.red, size: 16),
                        SizedBox(width: 4),
                        commonText("Opens at 11:00 AM",
                            color: Colors.red, size: 12),
                            Spacer()
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 16),
        
                  /// Tab bar (static for now)
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      tabButton("Deals", 0, selectedIndex: selectedTabIndex, onTap: (i) {
                        setState(() => selectedTabIndex = i);
                      }),
                      tabButton("Reviews", 1, selectedIndex: selectedTabIndex, onTap: (i) {
                        setState(() => selectedTabIndex = i);
                      }),
                      tabButton("Information", 2, selectedIndex: selectedTabIndex, onTap: (i) {
                        setState(() => selectedTabIndex = i);
                      }),
                    ],
                  ),
                ),

        
                  const SizedBox(height: 16),
        
                  /// Deal Cards
                  buildDealCard(title: "2 for 1",subText: "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.", duration: "60 Days",location:  "Gulshan 2."),
                  buildDealCard(title: "Free cold drinks",subText: "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.", duration: "60 Days", location: "Gulshan 2."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget tabButton(String text, int index, {required int selectedIndex, required Function(int) onTap}) {
  final bool isActive = index == selectedIndex;
  return Expanded(
    child: GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: commonText(
            text,
            color: isActive ? Colors.white : Colors.black,
            isBold: true,
          ),
        ),
      ),
    ),
  );
}

  Widget buildDealCard({required String title,required String subText,required String duration, required String location}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16,top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Badge
          
              const SizedBox(height: 8),
        
              commonText(title, size: 16, isBold: true),
              const SizedBox(height: 8),
              commonText(
                  subText,
                  size: 13,
                  color: Colors.black87),
              const SizedBox(height: 12),
        
              /// Info Row
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Image.asset("assets/images/time.png")),
                          const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              commonText("Reusable After", size: 12),
                          commonText(duration, size: 12,isBold: true),
                          ],
                        ),
                          
                            
                        ],
                      ),
                    ),
                  ),Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Image.asset("assets/images/location2.png")),
                          const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              commonText("Location", size: 12),
                          commonText(location, size: 12,isBold: true),
                          ],
                        ),
                          
                            
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 12),
        
              /// Book button
              commonButton("Book deal", color: AppColors.primaryColor,height: 40),
            ],
          ),
        ),
     
         Align(
          alignment: Alignment.topCenter,
           child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: commonText("6 € Benefit",
                      color: Colors.white, size: 12, isBold: true),
                ),
         ),
      ],
    );
  }
}
