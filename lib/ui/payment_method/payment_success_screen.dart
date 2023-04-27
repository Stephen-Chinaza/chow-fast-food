import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../res/app_routes.dart';
import '../widgets/button_view.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Widget? child;
  const PaymentSuccessScreen({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: ListView(
          shrinkWrap: true,
          children: [
            const ImageView.svg(AppImages.icSuccess),
            const SizedBox(
              height: 30,
            ),
            child!,
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 97, horizontal: 15),
              child: ButtonView(
                  onPressed: () {
                    Navigator.popUntil(context, (route)
                    => route.settings.name == AppRoutes.dashboard);
                  },
                  child: const Text('Close',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
