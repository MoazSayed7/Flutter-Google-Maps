import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/cubit/phnoe_auth/phone_auth_cubit.dart';
import '../widgets/phone_field.dart';
import '../widgets/phone_number_submitted_bloc_listener.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  RegExp egyptianPhoneNumberRegex = RegExp(r'^(010|011|012|015)\d{8}$');

  String phoneNumber = '';

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
          key: _phoneFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroTexts(context),
                SizedBox(
                  height: height / 7.0,
                ),
                PhoneFormField(
                  formKey: _phoneFormKey,
                  onSaved: (value) {
                    if (value.length == 10) {
                      phoneNumber = '0$value';
                    } else {
                      phoneNumber = value;
                    }
                  },
                ),
                SizedBox(
                  height: height / 12.0,
                ),
                _buildNextButton(context),
                PhoneNumberSubmittedBlocListener(
                  phoneNumber: phoneNumber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildIntroTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is your phone number',
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
          margin: EdgeInsets.symmetric(
            horizontal: 2.w,
          ),
          child: Text(
            'Please enter a phone number to verify your account.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        )
      ],
    );
  }

  Align _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          _showProgressIndicator(context);
          _register(context);
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
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    Navigator.pop(context);
    if (!_phoneFormKey.currentState!.validate()) {
      return;
    } else {
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  void _showProgressIndicator(BuildContext context) async {
    const AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    await showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
