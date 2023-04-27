import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/ui/plans/widget/choose_action_dialog.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../model/data_models/plan/meal.dart';
import '../../../res/app_images.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/order_button.dart';

class ActiveMealCard extends StatelessWidget {
  final Meal meal;
  final bool edit;
  final Function? onEdit;
  final Function? onChange;
  final Function? onRemove;
  const ActiveMealCard(this.meal, {Key? key})
      : edit = false,
        onChange = null,
        onEdit = null,
        onRemove = null,
        super(key: key);

  const ActiveMealCard.edit(this.meal,
      {this.onEdit, this.onChange, this.onRemove, Key? key})
      : edit = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = meal.product;
    return Card(
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ImageView.network(product.image,
                    height: 96, width: 96, fit: BoxFit.fill),
              ),
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
                        Expanded(
                          child: CustomText(
                            text: product.description.capitalizeFirstOfEach,
                            color: Colors.black,
                            size: 16,
                            weight: FontWeight.w700,
                          ),
                        ),
                        if (edit) ...[
                          const SizedBox(width: 5),
                          InkWell(
                              child: const Icon(Icons.more_horiz),
                              onTap: () => Modals.showBottomSheetModal(context,
                                          heightFactor: 0.35,
                                          isScrollControlled: true,
                                          page: const ChooseActionDialog())
                                      .then((result) {
                                    if (result != null) {
                                      switch (result) {
                                        case 'edit':
                                          {
                                            if (onEdit != null) onEdit!();
                                            break;
                                          }
                                        case 'change':
                                          {
                                            if (onChange != null) onChange!();
                                            break;
                                          }
                                        case 'delete':
                                          {
                                            if (onRemove != null) onRemove!();
                                            break;
                                          }
                                      }
                                    }
                                  }))
                        ]
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: product.vendor?.businessName ?? '',
                            color: Theme.of(context).textTheme.caption!.color,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        OrderButton.outline(
                          width: 80,
                          height: 25,
                          borderRadius: 6.0,
                          onPressed: () {},
                          child: Center(
                            child: CustomText(
                              text: 'Combo',
                              color: Theme.of(context).colorScheme.secondary,
                              size: 14,
                            ),
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text.rich(TextSpan(children: [
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(0, 0),
                                child: Text('NGN ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .color,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ),
                            ),
                            TextSpan(
                                text: AppUtils.convertPrice(product.price),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 18))
                          ])),
                        ),
                        const SizedBox(width: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const ImageView.svg(AppImages.icClockTickOutline,
                                color: Colors.red),
                            const SizedBox(width: 5),
                            Text(AppUtils.timeFormat.format(meal.dueTime),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
