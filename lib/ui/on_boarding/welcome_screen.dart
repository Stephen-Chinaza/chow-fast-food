
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/data_models/onboard.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  late Timer _timer;

  final PageController _controller= PageController(
      initialPage: 0,
      viewportFraction: 1.0
  );

  final List<OnBoard> _onboard=[
    OnBoard(title: 'Order Food from Restaurant near you',
        description: 'Choose from variety of Restaurants near you to fill your meal request.'),
    OnBoard(title: 'Order Food from Restaurant near you',
        description: 'Choose from variety of Restaurants near you to fill your meal request.'),
    OnBoard(title: 'Order Food from Restaurant near you',
        description: 'Choose from variety of Restaurants near you to fill your meal request.'),
    OnBoard(title: 'Order Food from Restaurant near you',
        description: 'Choose from variety of Restaurants near you to fill your meal request.')
  ];

  @override
  void initState() {
    super.initState();

    _timer=Timer.periodic(const Duration(seconds: 10), (timer) {
      if(_controller.page!.round()<_onboard.length-1){
        _next();
      }
    });

  }

  void _next([int? index])=>_controller.animateToPage(
      index ?? ((_controller.page!.round() + 1) % _onboard.length),
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear);

  @override
  Widget build(BuildContext context) {
    final size=AppUtils.deviceScreenSize(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.welcomeBg),
              fit: BoxFit.fill,
              alignment: Alignment.center
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _onboard.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_onboard[index].title,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: size.width*0.15),
                          Text(_onboard[index].description,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    );
                  }, // Can be null
                ),
              ),
              SizedBox(height: size.width*0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SmoothPageIndicator(
                    controller: _controller,  // PageController
                    count:  _onboard.length,
                    effect: ExpandingDotsEffect(
                      dotWidth:  20.0,
                      dotHeight:  6.0,
                      expansionFactor: 1.5,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Theme.of(context).primaryColor.withOpacity(0.5)
                    ),
                    onDotClicked: (index)=>_next(index)
                ),
              ),
              SizedBox(height: size.width*0.28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ButtonView(onPressed: ()=>AppNavigator
                    .pushAndReplaceName(context,
                    name: AppRoutes.signInScreen),
                    color: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    borderRadius: 8.0,
                    child: Text('Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary,
                          fontSize: 18, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}