import 'package:flutter/material.dart';

class DealProgressBar extends StatelessWidget {
  final String redeemedRedeemedAt;
  final int reuseableAfter;

  DealProgressBar({
    required this.redeemedRedeemedAt,
    required this.reuseableAfter,
  });

  @override
  Widget build(BuildContext context) {
    // Convert redeemedRedeemedAt to DateTime
    DateTime redeemedDate = DateTime.parse(redeemedRedeemedAt);

    // Calculate the next available date (reuseableAfter days after redeemedRedeemedAt)
    DateTime nextAvailableDate = redeemedDate.add(
      Duration(days: reuseableAfter),
    );

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the remaining days
    int remainingDays = nextAvailableDate.difference(currentDate).inDays;

    // If the deal is already reusable, set remaining days to 0
    if (remainingDays < 0) {
      remainingDays = 0;
    }

    // Calculate the percentage of time passed relative to the total reuseableAfter period
    double progress = (reuseableAfter - remainingDays) / reuseableAfter;

    // Calculate the width for the progress indicator (the left blue semi-circle)
    double progressWidth =
        progress *
        (MediaQuery.of(context).size.width -
            40); // Subtracting some padding for the text area

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD0DFFF), // Light blue background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Left Blue Semi-circle (represents the progress)
              Container(
                width:
                    progressWidth, // The width is calculated based on the progress
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
              ),

              // The remaining part of the progress bar (text area)
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "In $remainingDays days bookable again",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
