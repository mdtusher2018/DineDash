
import 'package:dine_dash/Razu/DealerReview/widget/custom_progress.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DealerReview extends StatefulWidget {
  const DealerReview({super.key,});

  @override
  State<DealerReview> createState() => _DealerReviewState();
}

class _DealerReviewState extends State<DealerReview> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _businessController = TextEditingController();
    final TextEditingController _ratingController = TextEditingController();
    final TextEditingController _sortByController = TextEditingController();
    // final TextEditingController ratingController = TextEditingController();
    final List<String> _items = ['Business A', 'Business B', 'Business C'];
    String _selectedItem = '';
    // @override
    // void dispose() {
    //   _ratingController.dispose();
    //   super.dispose();
    // }
    // int index=5;
    List ratting=[
      { "ratting": "5.0"},
      { "ratting": "4.0"},
      { "ratting": "3.0"},
      { "ratting": "2.0"},
      { "ratting": "2.5"},
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 64,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("120 ",size: 30,fontWeight: FontWeight.w600),
                      commonText("Total Reviews",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("4.7",size: 30,fontWeight: FontWeight.w600),
                      commonText("Average Rating",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText("60",size: 30,fontWeight: FontWeight.w600),
                      commonText("Positive Reviews",size: 14,fontWeight: FontWeight.w400),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 38),
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    commonText("Rating Distribution",size: 16,fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context,index){
                        double ratingValue = double.parse(ratting[index]['ratting']);
                      return Row(
                        spacing: 10,
                        children: [
                          commonText("${5-index}*",size: 20,fontWeight: FontWeight.w500),
                          RatingProgressBar(rating: ratingValue),
                        ],
                      );
                    })
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 340,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      spacing: 5,
                      children: [
                       Image.asset("assets/images/filter.png",height: 25,width: 25,),
                        commonText("Filters",size: 18,fontWeight: FontWeight.w700),
                      ],
                    ),
                    commonText("Business",size: 14,fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    GestureDetector(
                      // onTap: () =>),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _businessController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select your business",
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    commonText("Rating",size: 14,fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    // Optional: Add custom tap behavior if needed
                  },
                  child: TextField(
                    controller: _ratingController,
                    readOnly: true, // Makes TextField non-editable
                    decoration: InputDecoration(
                      hintText: _selectedItem.isEmpty ? 'Select your business' : _selectedItem, // Update hintText with selected item
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          setState(() {
                            _selectedItem = value; // Update selected item for hintText
                            _ratingController.clear(); // Clear TextField content
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return _items.map((String item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                    SizedBox(height: 10,),
                    commonText("Sort By",size: 14,fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    GestureDetector(
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _sortByController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select your business",
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              ListView.builder(
                shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context,index){
                return  Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 194,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/images/profilepic.png",fit: BoxFit.fill,),
                          ),
                          commonText("John Doe",size: 18,fontWeight: FontWeight.w700),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Image.asset("assets/images/noted.png",height:30,width:30,fit: BoxFit.fill,),
                          commonText("The Cafe Rio",size: 14,fontWeight: FontWeight.w500,color: Color(0xff555555)),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            itemSize: 20,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 15,
                            child: VerticalDivider(thickness: 1,color: Colors.grey,),
                          ),
                          commonText("2 days ago",size: 14,fontWeight: FontWeight.w600,color: Color(0xff555555)),
                        ],
                      ),
                      commonText("Amazing food and great service! The happy hour deal was fantastic. Will definitely come back.",size: 14,fontWeight: FontWeight.w500,color: Color(0xff555555)),
                      Container(
                        height: 32,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffB7CDF5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonText("Used :",size: 16,fontWeight: FontWeight.w400),
                            commonText(" Free Drinks",size: 16,fontWeight: FontWeight.w400),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })


            ],
          ),
        ),
      ),
    );
  }
}
