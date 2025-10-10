import 'package:dine_dash/features/business/dealer/add_menu_page.dart';
import 'package:dine_dash/features/business/dealer/edit_menu_page.dart';
import 'package:dine_dash/features/deals/dealer/edit_deals.dart';
import 'package:dine_dash/features/deals/dealer/widgets/buildDealCard.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/features/deals/dealer/create_deal.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:get/get.dart';

import '../user/all_review_of_business.dart';

class DealerBusinessDetailsPage extends StatefulWidget {
  const DealerBusinessDetailsPage({Key? key}) : super(key: key);

  @override
  State<DealerBusinessDetailsPage> createState() => _DealerBusinessDetailsPageState();
}

class _DealerBusinessDetailsPageState extends State<DealerBusinessDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> deals = [
    {
      "title": "2 for 1",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
      'redeemed':"36",
      "benefit": "6 € Benefit",
      "status": "Active",
    },
    {
      "title": "Free Drinks",
      "subText":
          "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
      "duration": "60 Days",
      "location": "Chef's Table",
      'redeemed':"36",
      "benefit": "6 € Benefit",
      "status": "Paused",
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Chef’s Table"),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildHeaderCard(),
          ),
          const SizedBox(height: 10),
          _buildStatsRow(),
          const SizedBox(height: 16),
          Divider(height: 1),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildDealsTab(), menuTab(), buildReviewsTab()],
            ),
          ),
        ],
      ),
    );
  }

Widget menuTab(){
  return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                      commonBorderButton("+ Add Items", onTap: () {
                   navigateToPage(AddMenuScreen());
          }),
          SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText("Example from the",size: 14),
                                      commonText("Menu", size: 18, isBold: true),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                           navigateToPage(EditMenuScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/editb.png",width: 16,),
                            commonText(" Edit",size: 12),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                commonText("The Rio Lounge",size: 16,fontWeight: FontWeight.w600),
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      minVerticalPadding: 8,
                      minTileHeight: 0,

                      contentPadding: EdgeInsets.all(0),
                      title: commonText(
                        "OPERA VEGAN",
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: commonText("Schoklade/Kaffe/Mango"),
                      trailing: commonText("10 €"),
                    );
                  },
                ),
              ],
            ),
          ),
        );
}


  Widget _buildHeaderCard() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Chef’s Table", size: 16, isBold: true),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      commonText(
                        "Downtown, 123 Main St",
                        size: 13,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFCCF3D9),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: commonText(
                      "2 active deals",
                      size: 12,
                      color: Color(0xFF168368)
                      
                      

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatBox("2", "Active Deals"),
          _buildStatBox("3", "Total Reviews"),
          _buildStatBox("3", "Redeemed Deals"),
        ],
      ),
    );
  }

  Widget _buildStatBox(String count, String label) {
    return Expanded(
      child: Column(
        children: [
          commonText(count, size: 18, isBold: true),
          commonText(label, size: 12, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.primaryColor,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(child: commonText("Deals (2)", size: 14, isBold: true)),
        Tab(child: commonText("Menu",size: 14,isBold: true),),
        Tab(child: commonText("Reviews (120)", size: 14, isBold: true)),
      ],
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// + Add Deal button
          commonBorderButton("+ Add Deal", onTap: () {
                   navigateToPage(AddDealScreen());
          }),

          const SizedBox(height: 20),

          /// Deal Cards
          ...deals.map(
            (deal) => buildDealCard(
              title: deal["title"],
              subText: deal["subText"],
              duration: deal["duration"],
              redeemed: deal["redeemed"],
              location: deal["location"],
              benefitText: deal["benefit"],
              status: deal["status"],
              onEdit: () {
                navigateToPage(EditDealScreen());
              },
              onDelete: (){

    showDeleteConfirmationDialog(
      context: context,
      title: "Delete Item",
      message: "Are you sure you want to delete this item? This action cannot be undone.",
      onDelete: () {
        // Perform deletion logic here
        print("Item deleted");
      },);

              },
              onToggleStatus: () {
                showPauseReasonDialog(context, (reason) {
                  print("User wants to pause because: $reason");
                  // Perform pause logic with reason
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Ratings Summary Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: commonText("Overall Feedback", size: 16, isBold: true),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            commonText("4.8", size: 28, isBold: true),
                            const SizedBox(width: 4),
                            Icon(Icons.star, size: 24),
                          ],
                        ),
                        const SizedBox(height: 4),
                        commonText(
                          "120 Ratings \n&\n50 Reviews",
                          size: 12,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: List.generate(5, (index) {
                          int star = 5 - index;
                          double percent = [0.9, 0.8, 0.5, 0.3, 0.1][index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                commonText("$star★", size: 12),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: percent,
                                        child: Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Reviews List
          buildReviewItem(
            name: "John Doe",
            stars: 4,
            timeAgo: "2 days ago",
            comment:
                "Amazing food and great service! The happy hour deal was fantastic. Will definitely come back.",
          ),
          buildReviewItem(
            name: "Emily Smith",
            stars: 5,
            timeAgo: "1 month ago",
            comment:
                "Great atmosphere and lovely staff. Everything went smoothly with the voucher.",
          ),
          buildReviewItem(
            name: "John Doe",
            stars: 4,
            timeAgo: "2 days ago",
            comment:
                "Good food quality and the student discount was helpful. Atmosphere could be better.",
          ),

          const SizedBox(height: 20),

          /// All Reviews Button
          commonButton(
            "All reviews (36)",
            height: 48,
            onTap: () => Get.to(AllReviewOfBusinessPage()),
          ),
        ],
      ),
    );
  }

  Widget buildReviewItem({
    required String name,
    required int stars,
    required String timeAgo,
    required String comment,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar + Name
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://tse1.mm.bing.net/th/id/OIP.HNY2Wi4N2JYdkAAU9oLPVgHaLH?rs=1&pid=ImgDetMain&o=7&rm=3",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              commonText(name, isBold: true, size: 16),
            ],
          ),
          const SizedBox(height: 6),

          /// Rating and Time
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < stars ? Colors.amber : Colors.grey.shade400,
                    size: 18,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 14, color: Colors.grey),
              const SizedBox(width: 8),
              commonText(timeAgo, size: 12, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 6),

          /// Comment
          commonText(comment, fontWeight: FontWeight.w500, size: 14),
        ],
      ),
    );
  }
}
