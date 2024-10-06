import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/mycolors.dart';

class OtpPinCodeField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onCompleted;
  final StreamController<ErrorAnimationType> errorController;
  const OtpPinCodeField({
    super.key,
    required this.onCompleted,
    required this.onChanged,
    required this.errorController,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      onChanged: onChanged,
      cursorColor: Colors.black,
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5.r),
        fieldHeight: 50.h,
        fieldWidth: 40.w,
        borderWidth: 1.w,
        activeColor: MyColors.blue,
        inactiveColor: MyColors.blue,
        activeFillColor: MyColors.lightBule,
        inactiveFillColor: Colors.white,
        selectedColor: MyColors.blue,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      textStyle: TextStyle(
        fontSize: 25.sp,
      ),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: onCompleted,
    );
  }
}
