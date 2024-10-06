import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phnoe_auth/phone_auth_cubit.dart';
import '../../constants/mycolors.dart';
import '../widgets/otp_bloc_listener.dart';
import '../widgets/otp_pin_code_field.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroTexts(context),
              SizedBox(
                height: height / 7.0,
              ),
              OtpPinCodeField(
                errorController: errorController,
                onCompleted: (code) => otpCode = code,
                onChanged: (code) => otpCode = code,
              ),
              SizedBox(
                height: height / 12.0,
              ),
              _buildVerifyButton(context),
              OtpBlocListener(fieldErrorController: errorController),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    errorController.close();
    super.dispose();
  }

  showProgressIndicator(BuildContext context) {
    const AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Column _buildIntroTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code numbers sent to you at ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                height: 1.4.h,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: widget.phoneNumber,
                  style: const TextStyle(
                    color: MyColors.blue,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          if (otpCode.length == 6) {
            showProgressIndicator(context);
            _login(context);
          } else {
            errorController.add(ErrorAnimationType.shake);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          maximumSize: Size(110.w, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: Text(
          'Verify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }
}
