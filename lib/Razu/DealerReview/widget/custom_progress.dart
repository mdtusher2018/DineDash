import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingProgressBar extends StatelessWidget {
  final double rating; // from 0 to 5

  const RatingProgressBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    const double maxRating = 5;
    const double totalWidth = 240;
    final double progressWidth = (rating / maxRating) * totalWidth;

    return Stack(
      children: [
        Container(
          height: 10,
          width: totalWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
        ),
        Positioned(
          child: Container(
            height: 10,
            width: progressWidth, // calculated width based on rating
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
            ),
          ),
        )
      ],
    );
  }
}
