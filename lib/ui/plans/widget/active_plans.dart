
import 'package:chow/ui/plans/widget/empty_widget.dart';
import 'package:flutter/material.dart';

import '../../../model/data_models/plan/meal_plan.dart';
import '../../../model/data_models/plan/plan.dart';
import '../../bookings/widget/daily_plan_widget.dart';
import 'plans_summary_card.dart';

class ActivePlans extends StatelessWidget {
  final List<MealPlan> plans;
  const ActivePlans(this.plans, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(plans.isEmpty){
      return const EmptyPlanWidget();
    }
    return ListView(
      padding: const EdgeInsets.all(15.0),
      physics: const BouncingScrollPhysics(),
      children: [
        const PlansSummaryCard(),
        for(MealPlan m in  plans)...[
          for(Plan p in m.plan)...[
            const SizedBox(height: 15),
            DailyPlanWidget(p)
          ]
        ]
      ],
    );
  }
  
}
