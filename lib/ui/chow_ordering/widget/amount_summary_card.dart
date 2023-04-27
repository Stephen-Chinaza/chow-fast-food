import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/custom_text.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class AmountSummaryCard extends StatelessWidget {
  final String amount;
  const AmountSummaryCard({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Subtotal',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'NGN $amount',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Delivery Fee',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'NGN 0',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Discount (0%)',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'NGN 0',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w400,
              ),
            ],
          ),
          const SizedBox(height: 29),
          const ImageView.svg(AppImages.icDottedLine),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Total',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 14,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'NGN $amount',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 18,
                weight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
