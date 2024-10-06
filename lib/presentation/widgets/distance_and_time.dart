import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/mycolors.dart';
import '../../data/models/routes.dart';

class DistanceAndTime extends StatelessWidget {
  final Routes? routes;
  final bool isDistanceAndTimeVisible;
  const DistanceAndTime(
      {super.key, this.routes, required this.isDistanceAndTimeVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDistanceAndTimeVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 90.h),
          SizedBox(
            width: 200.w,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              margin: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0.h),
              color: Colors.white,
              child: ListTile(
                dense: true,
                horizontalTitleGap: 0,
                leading: Icon(
                  Icons.access_time_filled_rounded,
                  color: MyColors.blue,
                  size: 30.sp,
                ),
                title: Text(
                  formatDuration(routes!.duration!),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200.w,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              margin: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 0.h),
              color: Colors.white,
              child: ListTile(
                dense: true,
                horizontalTitleGap: 0,
                leading: Icon(
                  Icons.directions_car_filled_outlined,
                  color: MyColors.blue,
                  size: 30.sp,
                ),
                title: Text(
                  formatDistance(routes!.distanceMeters!),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDistance(int meters) {
    if (meters < 1000) {
      return '$meters m';
    } else {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(2)} Km';
    }
  }

  String formatDuration(String secondsString) {
    String cleanedString = secondsString.replaceAll('s', '');
    int seconds = int.tryParse(cleanedString) ?? 0;

    if (seconds < 60) {
      return '$seconds S';
    } else if (seconds < 3600) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return '$minutes M ${remainingSeconds > 0 ? "$remainingSeconds S" : ""}';
    } else {
      int hours = seconds ~/ 3600;
      int remainingMinutes = (seconds % 3600) ~/ 60;
      return '$hours H ${remainingMinutes > 0 ? "$remainingMinutes M" : ""}';
    }
  }
}
