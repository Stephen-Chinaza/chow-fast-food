import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../home/widgets/summary_card.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';

class ComboMealCard extends StatelessWidget {
  const ComboMealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SummaryCard(
        height: 185,
        bgEffect: AppImages.bgBalanceCardRight,
        color: AppColors.red,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const Positioned(
                      top: 20,
                      right: 0,
                      child: ImageView.svg(
                        AppImages.comboImage,
                        width: 250,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Combo Meal',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Theme.of(context).canvasColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create a custom combo meal \nfor yourself, friends or love ones.',
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
                                name: AppRoutes.createComboMealScreen);
                          },
                          expanded: false,
                          color: Theme.of(context).primaryColor,
                          borderWidth: 1,
                          borderColor: Theme.of(context).canvasColor,
                          borderRadius: 4.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: const Text('Create Combo',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.red)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
