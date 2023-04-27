import 'package:flutter/material.dart';

import '../../../model/data_models/plan/meal_plan.dart';
import '../../widgets/empty_widget.dart';
import 'completed_meal_card.dart';


class CompletedPlans extends StatelessWidget {
  final List<MealPlan> plans;
  const CompletedPlans(this.plans,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(plans.isEmpty){
      return const EmptyWidget(
        description: 'No completed plans yet',
      );
    }
    return ListView.builder(
      itemCount: plans.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(15.0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index)
      =>CompletedMealCard(plans[index])
    );
  }
  
}
