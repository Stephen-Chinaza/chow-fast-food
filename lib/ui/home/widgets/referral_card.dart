
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';
import 'summary_card.dart';

class ReferralCard extends StatelessWidget {
  const ReferralCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SummaryCard(
        bgEffect: AppImages.bgBalanceCardLeft,
        color: AppColors.yellow,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Referral Bonus',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Theme.of(context).canvasColor
                    ),
                  ),
                  const Spacer(),
                  Text('Refer a friend and earn bonuses on the Chow App',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Theme.of(context).canvasColor
                    ),
                  ),
                  const Spacer(),
                  ButtonView(onPressed: (){},
                      expanded: false,
                      color: Colors.transparent,
                      borderWidth: 1,
                      borderColor: Theme.of(context).canvasColor,
                      borderRadius: 6.0,
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      child: const Text('Refer Now',
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 13)))
                ],
              ),
            ),
            const SizedBox(width: 15),
            const ImageView.svg(AppImages.icReferralBonus),
            const SizedBox(width: 15)
          ],
        ));
  }
}
