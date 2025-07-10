import 'package:dine_dash/delar/BusinessDealsPage.dart';
import 'package:dine_dash/delar/bussiness/add_bussiness.dart';
import 'package:dine_dash/delar/bussiness/add_new_bussiness.dart';
import 'package:dine_dash/delar/create_deal.dart';
import 'package:dine_dash/delar/deals/dealer_deals.dart';
import 'package:dine_dash/user/home/RestaurantDetailsPage.dart';
import 'package:dine_dash/user/home/deal_blocked.dart';
import 'package:dine_dash/user/profile/contact_us.dart';
import 'package:dine_dash/user/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      home: AddBusinessScreen(),
    );
  }
}
