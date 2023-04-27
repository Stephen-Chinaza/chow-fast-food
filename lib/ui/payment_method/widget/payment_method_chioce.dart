import 'dart:async';

import 'package:chow/res/app_colors.dart';
import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class PaymentChoiceCard extends StatefulWidget {
  static StreamController<int> pageIndexController =
      StreamController<int>.broadcast();
  static Stream indexNotifier = pageIndexController.stream;

  final bool? isTopupPage;

  const PaymentChoiceCard({Key? key, this.isTopupPage = false})
      : super(key: key);

  @override
  PaymentChoiceCardState createState() => PaymentChoiceCardState();
}

class PaymentChoiceCardState extends State<PaymentChoiceCard> {
  int initPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  _isSelected({required int index}) {
    setState(() {
      initPageIndex = index;
      PaymentChoiceCard.pageIndexController.sink.add(index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 185,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            size: 24,
            text: 'Choose payment method',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w600,
          ),
          const SizedBox(
            height: 11,
          ),
          CustomText(
            size: 14,
            text: 'Select your payment method to proceed.',
            color: Theme.of(context).textTheme.caption!.color,
            weight: FontWeight.w400,
          ),
          const SizedBox(
            height: 22,
          ),
          (widget.isTopupPage!)
              ? topUpChoiceRow(context)
              : paymentChoiceRow(context),
        ],
      ),
    );
  }

  paymentChoiceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        singleChoiceCard(
          context: context,
          index: 0,
          img1: AppImages.icWallet,
        ),
        singleChoiceCard(
          context: context,
          index: 1,
          img1: AppImages.icCard,
        ),

        Container()
        // singleChoiceCard(
        //   context: context,
        //   index: 2,
        //   img1: AppImages.icBank,
        // ),
      ],
    );
  }

  topUpChoiceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        singleChoiceCard(
          context: context,
          index: 0,
          img1: AppImages.icCard,
        ),
        // singleChoiceCard(
        //   context: context,
        //   index: 1,
        //   img1: AppImages.icBank,
        // ),
        Container()
      ],
    );
  }

  singleChoiceCard({
    required BuildContext context,
    required index,
    required String img1,
  }) {
    return (initPageIndex == index)
        ? GestureDetector(
            onTap: (() {
              _isSelected(index: index);
            }),
            child: Container(
              height: 68,
              width: 68,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary)),
              child: Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ImageView.svg(
                    img1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: (() {
              _isSelected(index: index);
            }),
            child: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.lightBackground),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ImageView.svg(
                  img1,
                ),
              ),
            ),
          );
  }
}
