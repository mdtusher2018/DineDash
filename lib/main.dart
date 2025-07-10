
import 'package:dine_dash/Razu/DealerHomePage/dealer_homepage.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/user/home/home_page.dart';
import 'package:dine_dash/user/notification/notification.dart';
import 'package:dine_dash/user/root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Razu/DealerBusinessPage/dealer_business_page.dart';
import 'Razu/DealerProfile/dealer_profile.dart';
import 'Razu/DealerReview/dealer_review.dart';
import 'Razu/DealerReview/widget/test.dart';
import 'Razu/UserProfileScreen/profile_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: RootPage(),
      debugShowCheckedModeBanner: false,
      home: DealerReview(),

//       home: Scaffold(
//         body: Container(
//         child: Column(
//           children: [
//
// Row(
//   children: [
//     commonText("4.0", size: 18, isBold: true),
//     SizedBox(width: 8),
//     Row(
//       children: List.generate(5, (index) {
//         return Icon(
//           index < 4 ? Icons.star : Icons.star_border,
//           color: Colors.amber,
//           size: 20,
//         );
//       }),
//     ),
//   ],
// )
//           ],
//         ),
//       ),
//       )
    );
  }
}
