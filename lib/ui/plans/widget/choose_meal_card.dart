import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/ui/plans/widget/chow_detail_dialog.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../model/data_models/product/product.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/order_button.dart';

class ChooseMealCard extends StatelessWidget {
  final Product? meal;
  const ChooseMealCard(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                child: ImageView.network(meal!.image,
                    height: 75, width: 75, fit: BoxFit.fill),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: meal!.description.capitalizeFirstOfEach,
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: ' meal.restaurantName',
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .color,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                                const SizedBox(height: 5),
                                Text.rich(TextSpan(children: [
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
                                      text: AppUtils.convertPrice(meal!.price),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 18))
                                ])),
                              ]),
                        ),
                        const SizedBox(width: 5),
                        OrderButton.outline(
                          width: 80,
                          height: 28,
                          borderRadius: 6.0,
                          onPressed: () => Modals.showBottomSheetModal(context,
                                  heightFactor: 1.0,
                                  isScrollControlled: true,
                                  borderRadius: 25,
                                  page: ChowDetailDialog(meal!))
                              .then((result) {
                            if (result != null) {
                              Navigator.pop(context, result);
                            }
                          }),
                          child: Center(
                            child: CustomText(
                              text: 'Pick this',
                              color: Theme.of(context).colorScheme.secondary,
                              size: 14,
                            ),
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
