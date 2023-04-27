import 'package:chow/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../bookings/widget/review_card.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_toggle.dart';
import '../../widgets/image_view.dart';

class FoodDetailsCard extends StatelessWidget {
  final String title;
  final String rating;
  final String distance;
  final List<String> options;

  final String address;
  const FoodDetailsCard(
      {Key? key,
      required this.title,
      required this.rating,
      required this.distance,
      required this.options,
      required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        color: Theme.of(context).primaryColor,
        height: 263,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              weight: FontWeight.w600,
              size: 24,
              maxLines: 1,
              text: title,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const ImageView.svg(AppImages.icHouse),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  weight: FontWeight.w500,
                  size: 13,
                  maxLines: 1,
                  text: address,
                  color: const Color(0xFF898A8D),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                ButtonView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
                  onPressed: () {},
                  expanded: false,
                  borderRadius: 8.0,
                  color: AppColors.yellow,
                  borderColor: AppColors.yellow,
                  child: Row(
                    children: [
                      const ImageView.svg(
                        AppImages.icStarWhite,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      CustomText(
                        weight: FontWeight.w400,
                        size: 14,
                        maxLines: 2,
                        text: rating,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => Modals.showBottomSheetModal(context,
                      borderRadius: 25,
                      page: _modalReviewsContent(context),
                      isScrollControlled: true,
                      heightFactor: 0.9),
                  child: CustomText(
                    weight: FontWeight.w500,
                    size: 12,
                    maxLines: 1,
                    text: 'See Detail Reviews',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ImageView.svg(
                      AppImages.icLocationGreen,
                      width: 20,
                    ),
                    const SizedBox(width: 12),
                    CustomText(
                      weight: FontWeight.w500,
                      size: 14,
                      maxLines: 1,
                      text: distance,
                      color: const Color(0xFF575757),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Modals.showBottomSheetModal(context,
                      borderRadius: 25,
                      page: _modalOpenHourContent(context),
                      isScrollControlled: true,
                      heightFactor: 0.9),
                  child: Row(
                    children: [
                      CustomText(
                        weight: FontWeight.w500,
                        size: 18,
                        maxLines: 1,
                        text: 'Open',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 9),
                      const ImageView.svg(
                        AppImages.icExclamation,
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.4),
            Expanded(
              child: CustomToggle(
                title: options,
                contentMargin: const EdgeInsets.all(8.0),
                scrollable: true,
                onSelected: (int i) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  _modalOpenHourContent(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                weight: FontWeight.w600,
                size: 24,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const ImageView.svg(
                  AppImages.dropDown,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48.2),
        const SizedBox(
            width: 43.17, child: ImageView.svg(AppImages.icClockOutline)),
        const SizedBox(height: 20.2),
        Center(
          child: CustomText(
            text: 'Opening Hours',
            weight: FontWeight.w600,
            size: 24,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: CustomText(
            text: 'Monday - Sarturday',
            weight: FontWeight.w500,
            size: 18,
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
        const SizedBox(height: 9),
        Center(
          child: CustomText(
              text: '9:00am  - 10:00pm',
              weight: FontWeight.w600,
              size: 18,
              color: Theme.of(context).textTheme.bodyText1!.color),
        ),
        const SizedBox(height: 32),
        Center(
          child: CustomText(
            text: 'Sunday',
            weight: FontWeight.w600,
            size: 18,
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: CustomText(
            text: '10:00pm  - 10:00pm',
            weight: FontWeight.w500,
            size: 18,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ],
    );
  }

  _modalReviewsContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const ImageView.svg(
                AppImages.dropDown,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 21.67,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) => const ReviewCard()))
            ],
          ),
        ),
      ],
    );
  }
}
