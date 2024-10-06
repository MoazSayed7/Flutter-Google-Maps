// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/mycolors.dart';

// ignore: must_be_immutable
class PhoneFormField extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final Function(String) onSaved;

  RegExp egyptianPhoneNumberRegex = RegExp(r'^(010|011|012|015)\d{8}$');

  PhoneFormField({
    super.key,
    required this.formKey,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.lightGrey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            child: Text(
              '${generateCountryFlag()} +20',
              style: TextStyle(
                letterSpacing: 2.w,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 25,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.blue,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            ),
            child: TextFormField(
              autofocus: true,
              style: TextStyle(
                fontSize: 18.sp,
                letterSpacing: 2.0.w,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length == 10) {
                  value = '0$value';
                }
                if (!egyptianPhoneNumberRegex.hasMatch(value)) {
                  return 'Please enter a valid Egyptian phone number';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                onSaved(value!);
              },
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';
    return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
  }
}
