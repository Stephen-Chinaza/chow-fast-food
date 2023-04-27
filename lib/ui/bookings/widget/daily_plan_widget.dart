import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/plans/plans.dart';
import '../../../model/data_models/plan/meal.dart';
import '../../../model/data_models/plan/plan.dart';
import '../../../utils/app_utils.dart';
import '../../plans/widget/active_meal_card.dart';

class DailyPlanWidget extends StatefulWidget {
  final Plan plan;
  const DailyPlanWidget(this.plan,
      {Key? key}) : super(key: key);

  @override
  State<DailyPlanWidget> createState() => _DailyPlanWidgetState();
}

class _DailyPlanWidgetState extends State<DailyPlanWidget> {

  Meal? get _breakFast{
    try{
      return widget.plan.meals?.singleWhere((m) => m.mealType.toLowerCase()=='breakfast');
    }catch(e){
      return null;
    }
  }

  Meal? get _launch{
    try{
      return widget.plan.meals?.singleWhere((m) => m.mealType.toLowerCase()=='lunch');
    }catch(e){
      return null;
    }
  }

  Meal? get _dinner{
    try{
      return widget.plan.meals?.singleWhere((m) => m.mealType.toLowerCase()=='dinner');
    }catch(e){
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel=context.watch<PlansCubit>().viewModel;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
            TextSpan(
                text: '${viewModel.activePlanCaption(widget.plan)}\n',
                style: const TextStyle(fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: AppUtils.dateFormat.format(widget.plan.planDate!),
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w600)
                  )
                ]
            )
        ),
        if(_breakFast!=null)...[
          const SizedBox(height: 15),
          _mealTitle('Breakfast'),
          ActiveMealCard(_breakFast!)
        ],
        if(_launch!=null)...[
          const SizedBox(height: 15),
          _mealTitle('Lunch'),
          ActiveMealCard(_launch!)
        ],
        if(_dinner!=null)...[
          const SizedBox(height: 15),
          _mealTitle('Dinner'),
          ActiveMealCard(_dinner!)
        ],
        const SizedBox(height: 15)
      ],
    );
  }

  Widget _mealTitle(String title)=>Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.caption!.color,
            fontSize: 24)),
  );

}
