
import 'package:chow/res/app_routes.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';

class VerificationView extends StatelessWidget {
  final VerificationStatus status;
  const VerificationView(this.status,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(status){
      case VerificationStatus.none:
        return ButtonView(onPressed: ()=>AppNavigator
            .pushAndStackNamed(context,
            name: AppRoutes.kycVerificationScreen),
            expanded: false,
            borderRadius: 12.0,
            color: AppColors.yellow,
            borderColor: AppColors.yellow,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 35.0),
            child: const Text('Verify KYC',
                style: TextStyle(fontWeight: FontWeight.w600,
                    fontSize: 14)));
      case VerificationStatus.pending:
        return const Text('KYC Under Review',
          style: TextStyle(fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.yellow));
      case VerificationStatus.verified:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Verified',
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(width: 5),
            const ImageView.svg(AppImages.icApproved)
          ],
        );
    }
  }
}
