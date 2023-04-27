import 'package:chow/res/app_colors.dart';
import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/custom_text.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_view.dart';
import '../../widgets/order_button.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String discount;
  final String title;
  final String titleSmall;
  final String details;
  final String rating;
  final String? duration;
  final String vendourType;
  final double titleSize;
  final FontWeight titleWeight;
  final String price;
  final double spacing;
  final void Function() onPressed;

  const ProductCard.near(
      {Key? key,
      required this.imageUrl,
      required this.discount,
      required this.title,
      required this.details,
      required this.rating,
      required this.duration,
      this.vendourType = 'near',
      this.titleSmall = '',
      this.titleWeight = FontWeight.w600,
      this.titleSize = 24,
      this.price = '',
      this.spacing = 0,
      required this.onPressed})
      : super(key: key);
  const ProductCard.popular(
      {Key? key,
      required this.imageUrl,
      required this.discount,
      required this.title,
      required this.details,
      required this.rating,
      required this.duration,
      this.vendourType = 'popular',
      this.titleSmall = '',
      this.titleWeight = FontWeight.w600,
      this.titleSize = 24,
      this.price = '',
      this.spacing = 0,
      required this.onPressed})
      : super(key: key);

  const ProductCard.hotDeals(
      {Key? key,
      required this.imageUrl,
      required this.discount,
      required this.title,
      required this.details,
      required this.rating,
      required this.duration,
      this.vendourType = 'hotdeals',
      this.titleSmall = '',
      this.titleWeight = FontWeight.w600,
      this.titleSize = 24,
      this.price = '',
      this.spacing = 0,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vendourType == 'near') {
      return InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            Stack(
              children: [
                if (imageUrl != '') ...[
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7.2),
                            topRight: Radius.circular(7.2)),
                        child: ImageView.network(imageUrl,
                            fit: BoxFit.cover, placeholder: AppImages.icon)),
                  ),
                ] else ...[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.2),
                          topRight: Radius.circular(7.2)),
                    ),
                    child: const ImageView.asset(
                      AppImages.icon,
                    ),
                  )
                ],
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 112.88,
                      height: 28.8,
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          weight: FontWeight.w600,
                          size: 13.2,
                          text: discount,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.2),
                              topRight: Radius.circular(7.2)),
                          image: DecorationImage(
                              image: AssetImage(AppImages.discountBg),
                              fit: BoxFit.fill)),
                    )),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.68,
                  padding: const EdgeInsets.only(bottom: 20, right: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(7.2),
                        right: Radius.circular(7.2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          CustomText(
                            weight: FontWeight.w700,
                            size: 18,
                            text: title,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            weight: FontWeight.w400,
                            size: 14,
                            maxLines: 2,
                            text: details,
                            color: Theme.of(context).textTheme.caption!.color,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: OrderButton.outline(
                                  width: 70,
                                  height: 32,
                                  borderRadius: 4.8,
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const ImageView.svg(
                                        AppImages.icStar,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        weight: FontWeight.w600,
                                        size: 14.4,
                                        maxLines: 2,
                                        text: rating,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ],
                                  ),
                                  color: AppColors.scaffoldColor,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Row(
                                  children: [
                                    const ImageView.svg(
                                      AppImages.icClockTickOutline,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    CustomText(
                                      weight: FontWeight.w400,
                                      size: 14,
                                      maxLines: 2,
                                      text: duration,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                  )),
            ),
          ],
        ),
      );
    } else if (vendourType == 'popular') {
      return InkWell(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            type: MaterialType.card,
            elevation: 2,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        if (imageUrl != '') ...[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(7.2),
                              child: ImageView.network(imageUrl,
                                  placeholder: AppImages.icon)),
                        ] else ...[
                          const Center(
                            child: ImageView.asset(
                              AppImages.icon,
                            ),
                          )
                        ],
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 69,
                              height: 24,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(AppImages.discountBg))),
                              child: Center(
                                child: CustomText(
                                  weight: FontWeight.w600,
                                  size: 9.4,
                                  maxLines: 1,
                                  text: discount,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            CustomText(
                              weight: FontWeight.w600,
                              size: 18,
                              text: title,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              weight: FontWeight.w400,
                              size: 13,
                              maxLines: 2,
                              text: details,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: OrderButton.outline(
                                    width: 90,
                                    height: 32,
                                    borderRadius: 4.8,
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 4),
                                        const ImageView.svg(
                                          AppImages.icStar,
                                          width: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        CustomText(
                                          weight: FontWeight.w400,
                                          size: 12,
                                          maxLines: 2,
                                          text: rating,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ],
                                    ),
                                    color: AppColors.scaffoldColor,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Row(
                                      children: [
                                        const ImageView.svg(
                                          AppImages.icClockTickOutline,
                                          width: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: CustomText(
                                            weight: FontWeight.w400,
                                            size: 14,
                                            maxLines: 1,
                                            text: duration,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (vendourType == 'hotdeals') {
      return InkWell(
        onTap: () => onPressed,
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    if (imageUrl != '') ...[
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(7.2),
                                topRight: Radius.circular(7.2)),
                            child: ImageView.network(imageUrl,
                                fit: BoxFit.fill, placeholder: AppImages.icon)),
                      ),
                    ] else ...[
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.2),
                              topRight: Radius.circular(7.2)),
                        ),
                        child: const ImageView.asset(
                          AppImages.icon,
                        ),
                      )
                    ],
                    (discount == '')
                        ? Container()
                        : Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 98,
                              height: 24,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(AppImages.discountBg))),
                              child: Center(
                                child: CustomText(
                                  weight: FontWeight.w600,
                                  size: 9.4,
                                  maxLines: 1,
                                  text: discount,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )),
                    (duration == '')
                        ? Container()
                        : Positioned(
                            left: 16,
                            bottom: 15,
                            child: SizedBox(
                              height: 30,
                              child: ButtonView(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 9),
                                onPressed: () {},
                                expanded: false,
                                borderRadius: 4.0,
                                color: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                                child: Row(
                                  children: [
                                    const ImageView.svg(
                                      AppImages.icClockTickOutline,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    CustomText(
                                      weight: FontWeight.w400,
                                      size: 14,
                                      maxLines: 2,
                                      text: duration,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: spacing),
                  child: Material(
                      type: MaterialType.card,
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(13.31),
                            bottomRight: Radius.circular(13.31)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.83),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (title == '')
                                ? const SizedBox.shrink()
                                : CustomText(
                                    weight: titleWeight,
                                    maxLines: 2,
                                    size: titleSize,
                                    text: title,
                                    color: const Color(0xFF333333),
                                  ),
                            (title == '')
                                ? const SizedBox.shrink()
                                : const SizedBox(
                                    height: 18,
                                  ),
                            (details == '')
                                ? const SizedBox.shrink()
                                : CustomText(
                                    weight: FontWeight.w400,
                                    size: 18,
                                    text: details,
                                    color: const Color(0xFF707070),
                                  ),
                            (details == '')
                                ? const SizedBox.shrink()
                                : const SizedBox(
                                    height: 12,
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (rating == '')
                                    ? Flexible(
                                        child: Text(titleSmall,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontSize: 14)),
                                      )
                                    : OrderButton.outline(
                                        width: 110,
                                        height: 32,
                                        borderRadius: 4.8,
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 8),
                                            const ImageView.svg(
                                              AppImages.icStar,
                                              width: 20,
                                            ),
                                            const SizedBox(width: 4.6),
                                            CustomText(
                                              weight: FontWeight.w600,
                                              size: 14.4,
                                              maxLines: 2,
                                              text: rating,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                            ),
                                          ],
                                        ),
                                        color: AppColors.scaffoldColor,
                                      ),
                                Text.rich(TextSpan(children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(0, 0),
                                      child: Text('NGN',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .color,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.4)),
                                    ),
                                  ),
                                  TextSpan(
                                      text: price,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 18))
                                ])),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Positioned(
                top: 195,
                right: 22,
                child: InkWell(
                  onTap: onPressed,
                  child: const SizedBox(
                      height: 38, child: ImageView.svg(AppImages.icAdd)),
                )),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
