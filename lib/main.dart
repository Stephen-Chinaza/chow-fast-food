import 'package:chow/model/view_models/meal_plan_view_model.dart';
import 'package:chow/model/view_models/products_view_model.dart';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/res/app_theme.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/view_models/notifications_view_model.dart';
import 'model/view_models/order_view_model.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.intialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ChangeNotifierProvider(create: (_) => ProductsViewModel()),
      ChangeNotifierProvider(create: (_) => MealPlanViewModel()),
      ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: themeData(AppTheme.lightTheme),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
        textTheme: GoogleFonts.barlowTextTheme(
          theme.textTheme,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ));
  }
}
