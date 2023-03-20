import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/theme/app_colors.dart';

class AppRating extends StatelessWidget {
  const AppRating({
    Key? key,
    this.size = 18,
    required this.onRatingUpdate,
    this.rating,
  }) : super(key: key);

  final double size;
  // final String asa;
  final Function(double) onRatingUpdate;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      unratedColor: AppColors.spanishGray,
      itemSize: size,
      updateOnDrag: false,
      initialRating: rating ?? 5,
      ignoreGestures: true,
      itemBuilder: (context, index) => Icon(
        rating! >= index + 1 ? Icons.star_rounded : Icons.star_border_rounded,
        color: AppColors.deepSaffron,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
