import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class OrderContent extends StatelessWidget {
  final OrderContentType? method;
  const OrderContent.food({Key? key, this.method = OrderContentType.food})
      : super(key: key);
  const OrderContent.officer({Key? key, this.method = OrderContentType.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (method == OrderContentType.food) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const ImageView.asset(AppImages.food2,
                  height: 96, width: 96, fit: BoxFit.fill),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Chizzy’s Food',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  size: 18,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: '3 Items',
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Waiting',
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ))
          ]);
    } else if (method == OrderContentType.profile) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const ImageView.asset(AppImages.person,
                  height: 49, width: 48, fit: BoxFit.fill),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'John Okafor',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  size: 18,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ImageView.svg(AppImages.icLocationOutline,
                        width: 12,
                        color: Theme.of(context).textTheme.caption!.color,
                        fit: BoxFit.fill),
                    const SizedBox(width: 10.52),
                    CustomText(
                      text: '3.2km away',
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            )),
            const Spacer(),
            const ImageView.svg(AppImages.icCall, fit: BoxFit.fill),
          ]);
    }

    return const SizedBox.shrink();
  }
}
