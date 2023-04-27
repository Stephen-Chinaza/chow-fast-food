
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import 'widgets/button_view.dart';
import 'widgets/image_view.dart';


class SuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final String bntText;
  const SuccessScreen({this.title = 'OTP Verified',
    this.message = 'Your phone number was successfully verified',
    this.bntText = 'Continue',
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageView.svg(AppImages.icVerified),
                  const SizedBox(height: 25),
                  Text(title,
                      style: const TextStyle(fontSize: 32,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 25),
                  Text(message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ButtonView(onPressed:
            ()=>Navigator.pop(context, true),
            child: Text(bntText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700))),
      ),
    );
  }
}

