import 'package:chow/model/data_models/plan/create_plan.dart';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/res/enum.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/plans/plans.dart';
import '../../../model/data_models/plan/meal.dart';
import '../../../model/data_models/plan/plan.dart';
import '../../../res/app_images.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';
import 'active_meal_card.dart';

class ChosenMealSummary extends StatefulWidget {
  final Plan plan;
  const ChosenMealSummary(this.plan, {Key? key}) : super(key: key);

  @override
  State<ChosenMealSummary> createState() => _ChosenMealSummaryState();
}

class _ChosenMealSummaryState extends State<ChosenMealSummary> {
  bool _recurring = true;

  Meal? get _breakFast {
    try {
      return widget.plan.meals
          ?.singleWhere((m) => m.mealType.toLowerCase() == 'breakfast');
    } catch (e) {
      return null;
    }
  }

  Meal? get _launch {
    try {
      return widget.plan.meals
          ?.singleWhere((m) => m.mealType.toLowerCase() == 'lunch');
    } catch (e) {
      return null;
    }
  }

  Meal? get _dinner {
    try {
      return widget.plan.meals
          ?.singleWhere((m) => m.mealType.toLowerCase() == 'dinner');
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final plansCubit = context.watch<PlansCubit>();
    final viewModel = plansCubit.viewModel;
    final user = Provider.of<UserViewModel>(context, listen: false).user!;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_breakFast != null) ...[
                const SizedBox(height: 15),
                _mealTitle('Breakfast'),
                ActiveMealCard(_breakFast!)
              ],
              if (_launch != null) ...[
                const SizedBox(height: 15),
                _mealTitle('Lunch'),
                ActiveMealCard(_launch!)
              ],
              if (_dinner != null) ...[
                const SizedBox(height: 15),
                _mealTitle('Dinner'),
                ActiveMealCard(_dinner!)
              ],
              const SizedBox(height: 25),
              const Text('Payment Details',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18))
            ],
          ),
        ),
        const SizedBox(height: 15),
        Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  for (int i = 0; i < viewModel.newPlans.length; i++) ...[
                    _summarySection(
                        'Day${i + 1}',
                        AppUtils.convertPrice(viewModel.dailyMealTotalPrice(i),
                            showCurrency: true)),
                  ],
                  _summarySection('Delivery fees', 'NGN 8,000'),
                  _summarySection('Sub-total', 'NGN 23,000'),
                  const SizedBox(height: 15),
                  const ImageView.svg(AppImages.icDottedLine),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        Text(
                            AppUtils.convertPrice(viewModel.planTotalPrice,
                                showCurrency: true),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
            )),
        CheckboxListTile(
            value: _recurring,
            title: const Text('Re-curring',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: const Text('Mark this as a re-curring plan',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
            activeColor: Theme.of(context).colorScheme.secondary,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => setState(() => _recurring = value!)),
        BlocConsumer<PlansCubit, PlansStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: ButtonView(
                  onPressed: () {
                    AppNavigator.pushAndStackNamed(context,
                        name: AppRoutes.paymentMethodScreen,
                        arguments: viewModel.planTotalPrice.toString()).then((method){
                      switch(method){
                        case PaymentMethod.card :{
                          final mealPlan = CreatePlan(
                              items: viewModel.newPlans,
                              latitude: user.longitude!,
                              longitude: user.latitude!,
                              location: user.location!,
                              duration: viewModel.duration,
                              paymentMethod: 'card');
                          plansCubit.createMealPlan(mealPlan);
                          break;
                        }
                        case PaymentMethod.wallet :{
                          final mealPlan = CreatePlan(
                              items: viewModel.newPlans,
                              latitude: user.longitude!,
                              longitude: user.latitude!,
                              location: user.location!,
                              duration: viewModel.duration,
                              paymentMethod: 'wallet');
                          plansCubit.createMealPlan(mealPlan);
                          break;
                        }
                        case PaymentMethod.bank :{
                          break;
                        }
                      }
                    });
                  },
                  borderRadius: 6,
                  processing: state is MealPlansProcessing,
                  child: const Text('Proceed to Payment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700))),
            );
          },
          listener: (_, state) {
            if (state is MealPlanCreated) {
              switch(state.paymentMethod){
                case 'card' :{
                  if(state.info.paymentUrl != null){
                    AppNavigator.pushAndStackNamed(context,
                        name: AppRoutes.webViewScreen,
                        arguments: state.info.paymentUrl)
                        .then((successful) {
                      if (successful != null) {
                        if (successful) {
                          Navigator.popUntil(context,
                                  (route) => route.settings.name == AppRoutes.dashboard);
                        } else {
                          Modals.showToast('Transaction failed',
                              messageType: MessageType.error);
                        }
                      }
                    });
                  }
                  break;
                }
                case 'wallet' :
                case 'transfer' :
                {
                  Navigator.popUntil(context,
                          (route) => route.settings.name == AppRoutes.dashboard);
                  break;
                }
              }
            }
          },
        )
      ],
    );
  }

  Widget _mealTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.caption!.color,
                fontSize: 18)),
      );

  Widget _summarySection(String caption, String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(caption,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            Text(value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
          ],
        ),
      );
}
