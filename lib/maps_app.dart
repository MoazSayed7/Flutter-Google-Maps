import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_router.dart';
import 'main.dart';

class MapsApp extends StatelessWidget {
  final AppRouter appRouter;
  const MapsApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
          ),
          title: 'Flutter Google Map',
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
