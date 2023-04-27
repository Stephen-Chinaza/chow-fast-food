import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../home/widgets/summary_card.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';

class CreateMealCard extends StatelessWidget {
  const CreateMealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SummaryCard(
        height: 185,
        bgEffect: AppImages.bgBalanceCardRight,
        color: const Color(0xFF48ACE3),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const Positioned(
                      top: 20,
                      right: 5,
                      child: ImageView.svg(AppImages.mealReceipt)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Meal Plan',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Theme.of(context).canvasColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create a custom meal plan for\n yourself, friends or love ones.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Theme.of(context).canvasColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonView(
                          onPressed: () {
                            AppNavigator.pushAndStackNamed(context,
                                name: AppRoutes.planScreen);
                          },
                          expanded: false,
                          color: Colors.transparent,
                          borderWidth: 1,
                          borderColor: Theme.of(context).canvasColor,
                          borderRadius: 6.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: const Text('Start Meal Plan',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
