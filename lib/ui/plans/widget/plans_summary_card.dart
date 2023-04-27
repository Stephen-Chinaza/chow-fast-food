import 'package:chow/model/view_models/meal_plan_view_model.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/progress_indicator.dart';

class PlansSummaryCard extends StatelessWidget {
  const PlansSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanViewModel>(
      builder: (BuildContext context, MealPlanViewModel viewModel, Widget? child) {
        final active = viewModel.inProgressMealPlans;
        return Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            shadowColor: Theme.of(context).shadowColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Active Plans',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              _dateWidget(caption: 'Start date',
                                  date: AppUtils.dateFormat.format(active.first.plan.first.planDate!)),
                              const SizedBox(width: 15),
                              _dateWidget(caption: 'End date',
                                  date: AppUtils.dateFormat.format(active.last.plan.last.planDate!))
                            ],
                          )
                        ]
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: ProgressIndicators
                            .circularProgressBar(context,
                            value: viewModel.progressPercentage/100,
                            strokeWidth: 10),
                        height: 60, width: 60,
                      ),
                      const SizedBox(height: 15),
                      Text('${viewModel.daysLeft} days Left',
                        style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary),)
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget _dateWidget({required String caption,
    required String date})=>Text.rich(
      TextSpan(
          text: '$caption\n',
          style: const TextStyle(fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: date,
                style: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w600)
            )
          ]
      )
  );

}
