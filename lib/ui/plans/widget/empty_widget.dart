import 'package:chow/res/app_routes.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';

class EmptyPlanWidget extends StatelessWidget {
  const EmptyPlanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ImageView.svg(AppImages.icEmptyMealPlan),
            const SizedBox(height: 25),
            const Text('No active plan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 25),
            const Text(
                'You do not have any active plan. '
                'Please set your meal plan to have it listed here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            const SizedBox(height: 25),
            ButtonView(
                onPressed: () => AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.setPlanScreen),
                child: const Text('Set Meal Plan',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
            const SizedBox(height: 25),
            ButtonView(
                onPressed: () {},
                borderWidth: 1,
                color: Colors.transparent,
                child: Text('Create Combo',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18)))
          ],
        ),
      ),
    );
  }
}
