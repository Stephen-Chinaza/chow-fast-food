import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../model/data_models/plan/meal_plan.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/order_button.dart';


class CompletedMealCard extends StatelessWidget {
  final MealPlan plan;
  const CompletedMealCard(this.plan,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Weekly Plan',
                size: 18,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: '${AppUtils.apiDateFormat.format(plan.plan.first.planDate!)} - '
                          '${AppUtils.apiDateFormat.format(plan.plan.last.planDate!)}',
                      color: Theme.of(context).textTheme.caption!.color,
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  OrderButton.outline(
                    width: 60,
                    height: 25,
                    borderRadius: 6.0,
                    onPressed: (){},
                    child: Center(
                      child: CustomText(
                        text: 'Renew',
                        color: Theme.of(context)
                            .colorScheme
                            .secondary,
                        size: 14,
                        weight: FontWeight.w500,
                      ),
                    ),
                    color:
                    Theme.of(context).colorScheme.secondary,
                  )
                ],
              )
            ],
          )
        ));
  }
}
