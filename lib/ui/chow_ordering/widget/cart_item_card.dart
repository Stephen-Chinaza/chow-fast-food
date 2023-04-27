import 'package:chow/res/app_colors.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../res/app_images.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/order_button.dart';
import '../../widgets/progress_indicator.dart';

class CartItemCard extends StatefulWidget {
  final void Function() onPressed;
  final bool processing;

  final int? defaultCount;
  final int minCount;
  final int? maxCount;
  final Function(int)? onChange;
  final String image;
  final String title;
  final String subTitle;
  final String currency;
  final String amount;
  final bool showCombo;
  final bool showQuantity;

  const CartItemCard(
      {Key? key,
      this.defaultCount,
      this.minCount = 0,
      this.maxCount,
      this.onChange,
      required this.onPressed,
      this.processing = false,
      required this.title,
      required this.subTitle,
      required this.currency,
      required this.amount,
      required this.showCombo,
      required this.image,
      required this.showQuantity})
      : super(key: key);

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int _count;

  void _increment() {
    if (widget.maxCount != null && _count >= widget.maxCount!) {
      return;
    }
    setState(() => _count++);
    if (widget.onChange != null) widget.onChange!(_count);
  }

  void _decrement() {
    if (_count <= widget.minCount) {
      return;
    }
    setState(() => _count--);
    if (widget.onChange != null) widget.onChange!(_count);
  }

  @override
  void initState() {
    _count = widget.defaultCount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Slidable(
          key: const ValueKey(1),
          endActionPane: ActionPane(
            dragDismissible: false,
            closeThreshold: 0.1,
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              (widget.processing)
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              ProgressIndicators.circularProgressBar(context)),
                    )
                  : GestureDetector(
                      onTap: widget.onPressed,
                      child: Container(
                          width: 48,
                          height: 115,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.23),
                            color: AppColors.red.withOpacity(0.2),
                          ),
                          child: const Center(
                              child: ImageView.svg(AppImages.icDeleteRed))),
                    )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.image != '') ...[
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(7.2),
                                topRight: Radius.circular(7.2)),
                            child: ImageView.network(widget.image,
                                placeholder: AppImages.icon,
                                height: 120,
                                width: 120)),
                      ] else ...[
                        const Center(
                          child: ImageView.asset(
                            AppImages.icon,
                          ),
                        )
                      ],
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: widget.subTitle,
                                    maxLines: 2,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                    size: 14,
                                    weight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                (widget.showCombo)
                                    ? OrderButton.outline(
                                        width: 80,
                                        height: 25,
                                        borderRadius: 6.0,
                                        onPressed: () {
                                          // AppNavigator.pushAndStackNamed(
                                          //     context,
                                          //     name: AppRoutes
                                          //         .createComboMealScreen);
                                        },
                                        child: Center(
                                          child: CustomText(
                                            text: 'Combo',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            size: 14,
                                          ),
                                        ),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              maxLines: 2,
                              text: widget.title,
                              color: Colors.black,
                              size: 16,
                              weight: FontWeight.w700,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text.rich(TextSpan(children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: Text(widget.currency,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                        text: widget.amount,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 18))
                                  ])),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      (widget.showQuantity)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  InkWell(
                                    onTap: _decrement,
                                    child: const SizedBox(
                                        height: 24,
                                        child:
                                            ImageView.svg(AppImages.icRemove)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('$_count',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: _increment,
                                    child: const SizedBox(
                                        height: 24,
                                        child: ImageView.svg(AppImages.icAdd)),
                                  ),
                                ])
                          : const SizedBox.shrink(),
                    ],
                  ),
                )),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
