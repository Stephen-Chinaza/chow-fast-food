import 'package:chow/ui/plans/widget/chosen_meal_summary.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/meal_plan_view_model.dart';
import 'daily_stepper.dart';


class PlanSummary extends StatefulWidget {
  const PlanSummary({Key? key}) : super(key: key);

  @override
  State<PlanSummary> createState() => _PlanSummaryState();
}

class _PlanSummaryState extends State<PlanSummary> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanViewModel>(
        builder: (BuildContext context, MealPlanViewModel viewModel, Widget? child){
          final plans=viewModel.newPlans;
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Meal Plan Summary',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              DailyStepper(
                  header: Row(
                    children: [
                      _dateWidget(caption: 'Start date',
                          date: AppUtils.dateFormat.format(plans.first.planDate!)),
                      const SizedBox(width: 35),
                      _dateWidget(caption: 'End date',
                          date: AppUtils.dateFormat.format(plans.last.planDate!))
                    ],
                  ),
                  contents: List.generate(plans.length, (index)
                  => ChosenMealSummary(plans[index], key: UniqueKey()))
              )

            ],
          );
        }
    );
  }

  Widget _dateWidget({required String caption,
    required String date})=>Text.rich(
      TextSpan(
          text: '$caption\n',
          style: const TextStyle(fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: date,
                style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w600)
            )
          ]
      )
  );
  
}
