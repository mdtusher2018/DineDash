import 'package:dine_dash/view/user/home/deal_blocked.dart';
import 'package:flutter/material.dart';
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/res/colors.dart';

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
      body: Stack(
        children: [
          Image.network(
            "https://tse4.mm.bing.net/th/id/OIP.r3wgjJHOPaQo1GnGCkMnwgHaE8?rs=1&pid=ImgDetMain&o=7&rm=3",
            height: MediaQuery.sizeOf(context).height * 0.35,
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
        ],
      ),

      bottomSheet: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
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
                        child: commonText(
                          "The Rio Lounge",
                          size: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/medel.png"),
                          SizedBox(width: 4),
                          commonText(
                            "5.0",
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          commonText("(120)", size: 12, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    children:
                        ["Cafe", "Juice", "Bar"]
                            .map(
                              (tag) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),

                                decoration: BoxDecoration(
                                  color: AppColors.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: commonText(tag),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 4),
                      commonText("Gulshan 2, Dhaka. ", size: 14),
                      commonText("(2.2 km)", size: 14),
                      Spacer(),
                      commonText(
                        "€€€€",
                        color: Colors.green,
                        isBold: true,
                        size: 14,
                      ),
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
                          label: commonText("Menu", isBold: true, size: 14),
                          onPressed: () {
                            showMenuBottomSheet(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.black,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.black,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.share_outlined),
                        ),
                      ),
                    ],
                  ),

                  Divider(),
                  SizedBox(height: 6),

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
                        Icon(Icons.circle, size: 4, color: Colors.red),
                        const SizedBox(width: 8),
                        commonText(
                          "Currently Closed",
                          color: Colors.red,
                          isBold: true,
                        ),
                        Spacer(),
                        Icon(Icons.access_time, color: Colors.red, size: 16),
                        SizedBox(width: 4),
                        commonText(
                          "Opens at 11:00 AM",
                          color: Colors.red,
                          size: 12,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Tab bar (static for now)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        tabButton(
                          "Deals",
                          0,
                          selectedIndex: selectedTabIndex,
                          onTap: (i) {
                            setState(() => selectedTabIndex = i);
                          },
                        ),
                        tabButton(
                          "Reviews",
                          1,
                          selectedIndex: selectedTabIndex,
                          onTap: (i) {
                            setState(() => selectedTabIndex = i);
                          },
                        ),
                        tabButton(
                          "Information",
                          2,
                          selectedIndex: selectedTabIndex,
                          onTap: (i) {
                            setState(() => selectedTabIndex = i);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(),

                  const SizedBox(height: 8),

                  /// Deal Cards
                  if (selectedTabIndex == 0)
                    Column(
                      children: [
                        buildDealCard(
                          title: "2 for 1",
                          subText:
                              "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
                          duration: "60 Days",
                          location: "Gulshan 2.",
                        ),
                        buildDealCard(
                          title: "Free cold drinks",
                          subText:
                              "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
                          duration: "60 Days",
                          location: "Gulshan 2.",
                        ),
                      ],
                    ),

                  if (selectedTabIndex == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(
                          "Ratings & Reviews",
                          size: 16,
                          isBold: true,
                          color: AppColors.primaryColor,
                        ),

                        Row(
                          children: [
                            commonText("4.0", size: 18, isBold: true),
                            SizedBox(width: 8),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color:
                                      index < 4
                                          ? Colors.amber
                                          : Colors.grey.shade400,
                                  size: 20,
                                );
                              }),
                            ),
                          ],
                        ),
                        commonText(
                          "120 ratings | 70 reviews",
                          color: Colors.blueGrey,
                          isBold: true,
                        ),

                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return buildReviews();
                          },
                        ),

                        commonButton("All reviews (36)"),
                      ],
                    ),
                  if (selectedTabIndex == 2) restaurantInfoTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabButton(
    String text,
    int index, {
    required int selectedIndex,
    required Function(int) onTap,
  }) {
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

  Widget buildDealCard({
    required String title,
    required String subText,
    required String duration,
    required String location,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16, top: 16),
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
              commonText(subText, size: 13, color: Colors.black87),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("assets/images/time222.png"),
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("Reusable After", size: 12),
                              commonText(duration, size: 12, isBold: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset("assets/images/location2.png"),
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("Location", size: 12),
                              commonText(location, size: 12, isBold: true),
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
              commonButton(
                "Book deal",
                color: AppColors.primaryColor,
                height: 40,
                onTap: () {
                  showDealBottomSheet(
                    context,
                    title: "Free cold drinks",
                    description:
                        "Lorem ipsum dolor sit amet consectetur. Rhoncus molestie amet non pellentesque.",
                    days: ["Today", "Tomorrow", "Monday", "Tuesday"],
                    selectedDay: "Today",
                    timeRange: "12:00 - 20:00",
                    dealCount: 15,
                    onDealTap: () {
                      navigateToPage(DealBlockedPage());
                    },
                  );
                },
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: commonText(
              "6 € Benefit",
              color: Colors.white,
              size: 12,
              isBold: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviews() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              SizedBox(width: 8),
              commonText("Jone Due", isBold: true, size: 16),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < 4 ? Colors.amber : Colors.grey.shade400,
                    size: 20,
                  );
                }),
              ),
              SizedBox(width: 4),
              Container(width: 1, height: 16, color: Colors.grey),
              SizedBox(width: 4),
              Flexible(child: commonText("1 month ago")),
            ],
          ),
          commonText(
            "This is a comment",
            fontWeight: FontWeight.w500,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget restaurantInfoTab() {
    final Map<String, String> openingHours = {
      "Monday": "Closed",
      "Tuesday": "Closed",
      "Wednesday": "11:00 - 20:00",
      "Thursday": "11:00 - 20:00",
      "Friday": "11:00 - 20:00",
      "Saturday": "11:00 - 20:00",
      "Sunday": "11:00 - 20:00",
    };

    final String today = "Thursday"; // Replace with dynamic logic if needed

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Location
        Row(
          children: [
            Image.asset(
              "assets/images/location2.png",
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(
                  "Location",
                  isBold: true,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
                commonText("Avenue road, Gulshan 2"),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Map preview (circular)
        Center(
          child: ClipOval(
            child: Image.network(
              'https://th.bing.com/th/id/R.e6a56687376115edc42563b61fef9044?rik=fwSanhEc0otGvQ&pid=ImgRaw&r=0',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 24),

        /// Contact
        Row(
          children: [
            Icon(Icons.phone_outlined, color: AppColors.primaryColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(
                  "Contact",
                  isBold: true,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
                commonText("32410052102"),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/clock.png"),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      commonText(
                        "Opening hours",
                        isBold: true,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                    ],
                  ),

                  ...openingHours.entries.map((entry) {
                    final isToday = entry.key == today;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: commonText(
                              entry.key,
                              color:
                                  isToday
                                      ? AppColors.primaryColor
                                      : Colors.black,
                              isBold: isToday,
                            ),
                          ),
                          commonText(
                            entry.value,
                            color:
                                isToday ? AppColors.primaryColor : Colors.black,
                            isBold: isToday,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("• "),
                      Flexible(
                        child: commonText(
                          "Opening hours might differ due to public holidays.",
                          size: 12,
                          color: Colors.black87,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  void showDealBottomSheet(
    BuildContext context, {
    required String title,
    required String description,
    required List<String> days,
    required String selectedDay,
    required String timeRange,
    required int dealCount,
    required VoidCallback onDealTap,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  commonText(title, size: 16, isBold: true),
                  const SizedBox(height: 8),

                  // Description
                  commonText(description, size: 13),
                  const SizedBox(height: 12),

                  const Divider(height: 1),

                  const SizedBox(height: 12),

                  // Day Section
                  commonText("Day", isBold: true, size: 14),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        days.map((day) {
                          final isSelected = day == selectedDay;
                          return GestureDetector(
                            onTap: () {
                              // Handle your selection logic here
                              // For example, update selectedDay state in your StatefulWidget
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.transparent
                                          : Colors.black,
                                ),
                              ),
                              child: commonText(
                                day,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Time Section
                  commonText("Time", isBold: true, size: 14),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 18),
                        const SizedBox(width: 8),
                        commonText(timeRange, size: 13, isBold: true),
                        const Spacer(),
                        commonText(
                          "$dealCount Deals",
                          size: 13,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // CTA Button
                  commonButton(
                    "Go to deal",
                    onTap: onDealTap,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("Example from the"),
                commonText("Menu", size: 18, isBold: true),
                Divider(),
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
                        size: 16,
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
      },
    );
  }
}
