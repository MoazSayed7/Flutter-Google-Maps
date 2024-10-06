import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_router.dart';
import 'constants/strings.dart';
import 'firebase_options.dart';
import 'maps_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen(
    (user) {
      if (user == null) {
        initialRoute = loginscreen;
      } else {
        initialRoute = mapscreen;
      }
    },
  );

  runApp(
    MapsApp(
      appRouter: AppRouter(),
    ),
  );
}

late String initialRoute;
