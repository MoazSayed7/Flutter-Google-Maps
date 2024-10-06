import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phnoe_auth/phone_auth_cubit.dart';
import '../../constants/strings.dart';

class OtpBlocListener extends StatelessWidget {
  final StreamController<ErrorAnimationType> fieldErrorController;
  const OtpBlocListener({super.key, required this.fieldErrorController});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOptVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapscreen);
        }
        if (state is ErrorOccurred) {
          fieldErrorController.add(ErrorAnimationType.shake);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 8),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
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
}
