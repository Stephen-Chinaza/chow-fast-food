import 'package:chow/res/app_images.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_routes.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import 'order_content.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            text: 'Order Details',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w700,
            size: 18,
          ),
          const SizedBox(height: 28),
          const OrderContent.food(),
          const SizedBox(
            height: 23.5,
          ),
          const Divider(),
          const SizedBox(
            height: 18.5,
          ),
          CustomText(
            text: 'Delivery Officer',
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: 14,
            weight: FontWeight.w700,
          ),
          const SizedBox(height: 17),
          const OrderContent.officer(),
          const SizedBox(height: 57),
          ButtonView(
            expanded: true,
            borderColor: Theme.of(context).textTheme.caption!.color,
            onPressed: () {
              AppNavigator.pushAndStackNamed(context,
                  name: AppRoutes.viewOrderOnMap);
            },
            borderWidth: 0.5,
            borderRadius: 6,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView.svg(AppImages.icLocationOutline,
                    color: Theme.of(context).textTheme.caption!.color,
                    width: 12,
                    fit: BoxFit.fill),
                const SizedBox(width: 12.26),
                CustomText(
                  text: 'View on map',
                  color: Theme.of(context).textTheme.caption!.color,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ]));
  }
}
