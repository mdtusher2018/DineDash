import 'package:dine_dash/commonWidgets.dart';
import 'package:flutter/material.dart';

class DealBlockedPage extends StatefulWidget {
  const DealBlockedPage({super.key});

  @override
  State<DealBlockedPage> createState() => _DealBlockedPageState();
}

class _DealBlockedPageState extends State<DealBlockedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(flex: 2,),
              Image.asset("assets/images/deal_block.png"),
              SizedBox(height: 16,),
              commonText("Deal booked!",size: 21,isBold: true),
              SizedBox(height: 8,),
              commonText("Enjoy the deal at The Rio Lounge. To reserve a table, please contact the restaurant.",textAlign: TextAlign.center,size: 16),
             SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
                 
                  Column(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      commonText("Saturday")
                    ],
                  ),SizedBox(width: 16,),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey,
                  ),SizedBox(width: 16,)
                  ,Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          commonText("Saturday")
                        ],
                      ),
                    ],
                  )
                ],
              )
          ,Spacer(flex: 3,),
            ],
          ),
        ),
      ),
    );
  }
}