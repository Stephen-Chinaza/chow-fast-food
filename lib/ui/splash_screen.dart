import 'dart:async';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/res/app_strings.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../res/app_images.dart';
import '../res/app_routes.dart';
import '../utils/navigator/page_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(const Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  Future<void> changeScreen() async {
    final userData =
        Provider.of<UserViewModel>(context, listen: false).userData;

    if (userData != null && userData.isLoggedIn!) {
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.dashboard);
    } else {
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.welcomeScreen);
    }

    //Show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView.svg(AppImages.logo,
                color: Theme.of(context).colorScheme.primary,
                fit: BoxFit.fitWidth,
                width: 85),
            const SizedBox(height: 15),
            Text.rich(
                TextSpan(
                    text: '${AppStrings.appName}\n',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        height: 1.5),
                    children: [
                      TextSpan(
                          text: 'Timely delivery...',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400))
                    ]),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
