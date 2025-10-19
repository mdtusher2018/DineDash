import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/model/business_model.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';

class AllReviewOfBusinessPage extends StatefulWidget {
  const AllReviewOfBusinessPage({super.key, required this.feedBacks});
  final List<FeedbackData> feedBacks;
  @override
  State<AllReviewOfBusinessPage> createState() =>
      _AllReviewOfBusinessPageState();
}

class _AllReviewOfBusinessPageState extends State<AllReviewOfBusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: commonText("Reviews", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.feedBacks.length,
        itemBuilder: (context, index) {
          final feedBack = widget.feedBacks[index];
          return buildReviewItem(
            name: feedBack.reviewer.fullName,
            image: feedBack.reviewer.image,
            stars: feedBack.rating,
            timeAgo: timeAgo(feedBack.createdAt.toString()),
            comment: feedBack.text,
          );
        },
      ),
    );
  }

  Widget buildReviewItem({
    required String name,
    required String image,
    required num stars,
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
                    image: NetworkImage(getFullImagePath(image)),
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
