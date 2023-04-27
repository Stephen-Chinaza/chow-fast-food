import 'package:chow/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/rating_view.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      child: Material(
          type: MaterialType.card,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RatingView(rating: 3),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                    color: Theme.of(context).textTheme.caption!.color,
                    maxLines: 5,
                    text:
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ',
                    size: 14,
                    weight: FontWeight.w400),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    CustomText(
                        color: Theme.of(context).textTheme.caption!.color,
                        text: 'By Richard',
                        size: 14,
                        weight: FontWeight.w400),
                    const SizedBox(width: 8),
                    CustomText(
                        color: Theme.of(context).textTheme.caption!.color,
                        text: ' .   ',
                        size: 14,
                        weight: FontWeight.w400),
                    CustomText(
                        color: Theme.of(context).textTheme.caption!.color,
                        text: '2 hours ago',
                        size: 14,
                        weight: FontWeight.w400),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
