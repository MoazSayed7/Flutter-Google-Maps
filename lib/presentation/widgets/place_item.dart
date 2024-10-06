import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/mycolors.dart';
import '../../data/models/place_suggestions.dart';

class PlaceItem extends StatelessWidget {
  final PlaceSuggestion place;
  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.symmetric(vertical: 8.h, horizontal: 8.w),
      padding: EdgeInsetsDirectional.symmetric(vertical: 4.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.lightBule,
              ),
              child: const Icon(
                Icons.place,
                color: MyColors.blue,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${place.placePrediction.structuredFormat.mainText.text}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: place
                        .placePrediction.structuredFormat.secondaryText.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
