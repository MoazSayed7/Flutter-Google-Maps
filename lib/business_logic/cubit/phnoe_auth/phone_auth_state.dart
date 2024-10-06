part of 'phone_auth_cubit.dart';

class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;
  ErrorOccurred({
    required this.errorMsg,
  });
}

class Loading extends PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

@immutable
sealed class PhoneAuthState {}

class PhoneNumberSubmited extends PhoneAuthState {}

class PhoneOptVerified extends PhoneAuthState {}
