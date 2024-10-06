import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/webservices/places_web_services.dart';

import 'business_logic/cubit/maps/maps_cubit.dart';
import 'business_logic/cubit/phnoe_auth/phone_auth_cubit.dart';
import 'constants/strings.dart';
import 'data/repo/maps_repo.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/map_screen.dart';
import 'presentation/screens/otp_screen.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  MapsCubit? mapsCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
    mapsCubit = MapsCubit(
      MapsRepository(placesWebServices: PlacesWebServices()),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginscreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpscreen:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );

      case mapscreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<MapsCubit>.value(
            value: mapsCubit!,
            child: const MapScreen(),
          ),
        );
    }
    return null;
  }
}
