import 'package:chow/res/app_colors.dart';
import 'package:chow/res/enum.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import 'custom_text.dart';
import 'image_view.dart';


class DeliveryStatusWidget extends StatelessWidget {
  final DeliveryStatus status;
  final Color? textColor;
  const DeliveryStatusWidget(this.status,
      {this.textColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon=status==DeliveryStatus.requested
        ? AppImages.icRequested: status==DeliveryStatus.pending
        ? AppImages.icPending : AppImages.icDelivered;

    final color=status==DeliveryStatus.requested
        ? AppColors.red: status==DeliveryStatus.pending
        ? AppColors.yellow : AppColors.lightSecondaryAccent;

    final caption=status==DeliveryStatus.requested
        ? '30 mins, left': status==DeliveryStatus.pending
        ? 'Pending' : 'Delivered';

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageView.svg(icon),
        const SizedBox(width: 5),
        CustomText(
          text: caption,
          color: textColor ?? color,
          textAlign: TextAlign.center,
          size: 12,
        ),
      ],
    );
  }
}
