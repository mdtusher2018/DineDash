import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllReviewOfBusinessPage extends StatefulWidget {
  const AllReviewOfBusinessPage({super.key});

  @override
  State<AllReviewOfBusinessPage> createState() => _AllReviewOfBusinessPageState();
}

class _AllReviewOfBusinessPageState extends State<AllReviewOfBusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.white,surfaceTintColor: Colors.transparent,title: commonText("Reviews",size: 21,isBold: true),centerTitle: true,),
      body: ListView.builder(
        
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
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
      },),
    );
  }
}