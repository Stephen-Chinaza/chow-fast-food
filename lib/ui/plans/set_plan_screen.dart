import 'package:chow/model/view_models/meal_plan_view_model.dart';
import 'package:chow/requests/repositories/meal_plan_repository/meal_plan_repository_impl.dart';
import 'package:chow/res/enum.dart';
import 'package:chow/ui/plans/widget/set_daily_meal.dart';
import 'package:chow/ui/plans/widget/set_duration.dart';
import 'package:chow/ui/widgets/stepper/custom_step.dart';
import 'package:chow/ui/widgets/stepper/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/plans/plans_cubit.dart';
import '../widgets/cart_icon.dart';
import 'widget/daily_meal_summary.dart';

class SetPlanScreen extends StatefulWidget {
  const SetPlanScreen({Key? key}) : super(key: key);

  @override
  State<SetPlanScreen> createState() => _SetPlanScreenState();
}

class _SetPlanScreenState extends State<SetPlanScreen> {

   int _currentStep=0;

   final _steps=<String>['Duration', 'Set Meals', 'Complete'];

  @override
  Widget build(BuildContext context) {

    final _contents=<Widget>[
      SetDuration(onCompleted:()=>_nextPage(1)),
      SetDailyMeal(onCompleted:()=>_nextPage(2)),
      const PlanSummary()
    ];

    return BlocProvider<PlansCubit>(
        create: (_) => PlansCubit(
          viewModel: Provider.of<MealPlanViewModel>(context, listen: false),
          mealPlanRepository: MealPlanRepositoryImpl()
        ),
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Set Plan',
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.w600)),
                actions: const [
                  CartIcon(),
                  SizedBox(width: 10)
                ]
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('Set up your meal plan',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: CustomStepper(
                      currentStep: _currentStep,
                      steps: List.generate(
                          _steps.length, (index) => CustomStep(
                          title: _steps[index],
                          content: _contents[index],
                          state: _currentStep > index ? CustomStepState.completed :
                          _currentStep == index ? CustomStepState.current:
                          CustomStepState.idle
                      ))),
                )
              ],
            )
        )
    );
  }

  void _nextPage(int index){
    setState(()=>_currentStep=index);
  }

}
