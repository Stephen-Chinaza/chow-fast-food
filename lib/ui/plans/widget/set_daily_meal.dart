import 'package:chow/ui/plans/widget/daily_stepper.dart';
import 'package:chow/ui/plans/widget/meal_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/meal_plan_view_model.dart';

class SetDailyMeal extends StatefulWidget {
  final void Function() onCompleted;
  const SetDailyMeal({required this.onCompleted,
    Key? key}) : super(key: key);

  @override
  State<SetDailyMeal> createState() => _SetDailyMealState();
}

class _SetDailyMealState extends State<SetDailyMeal> {

  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanViewModel>(
        builder: (BuildContext context, MealPlanViewModel viewModel, Widget? child)
        =>ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 15),
            DailyStepper(
              header: const Text('Set meal for each day',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600)),
              onCompleted: widget.onCompleted,
              contents: List.generate(viewModel.newPlans.length, (index)
              => MealSelection(day: index, key: UniqueKey()))
            )
          ],
        )
    );
  }

}
