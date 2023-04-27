import 'package:chow/blocs/plans/plans.dart';
import 'package:chow/model/data_models/plan/meal.dart';
import 'package:chow/ui/plans/choose_chow_screen.dart';
import 'package:chow/ui/plans/widget/active_meal_card.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modals.dart';
import '../../widgets/button_view.dart';
import 'chow_detail_dialog.dart';

class MealSelection extends StatefulWidget {
  final int day;
  const MealSelection({required this.day,
    Key? key}) : super(key: key);

  @override
  State<MealSelection> createState() => _MealSelectionState();
}

class _MealSelectionState extends State<MealSelection> {

  bool _editBreakfast=false;
  Meal? _breakfast;

  bool _editLunch=false;
  Meal? _lunch;

  bool _editDinner=false;
  Meal? _dinner;

  late PlansCubit _plansCubit;

  @override
  void didChangeDependencies() {
    _plansCubit=context.watch<PlansCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          _mealBox(caption: 'Breakfast',
              check: _editBreakfast,
              selectedMeal: _breakfast,
              onSelected: (meal)=>setState(()=>_breakfast=meal),
              onChecked: (value)=>setState(()=>_editBreakfast=value!)),
          _mealBox(caption: 'Lunch',
              check: _editLunch,
              selectedMeal: _lunch,
              onSelected: (meal)=>setState(()=>_lunch=meal),
              onChecked: (value)=>setState(()=>_editLunch=value!)),
          _mealBox(caption: 'Dinner',
              check: _editDinner,
              selectedMeal: _dinner,
              onSelected: (meal)=>setState(()=>_dinner=meal),
              onChecked: (value)=>setState(()=>_editDinner=value!)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ButtonView(
                onPressed: (){
                  final List<Meal> meals=[];
                  if(_breakfast!=null)meals.add(_breakfast!);
                  if(_lunch!=null)meals.add(_lunch!);
                  if(_dinner!=null)meals.add(_dinner!);
                  _plansCubit.setDailyPlan(meals, day: widget.day);
                },
                child: const Text('Continue',
                    style:
                    TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 18))),
          )

        ],
      ),
    );
  }

  Widget _mealBox({ValueChanged<bool?>? onChecked,
    required ValueChanged<Meal?> onSelected,
    required String caption,
    Meal? selectedMeal,
    required bool check})=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: check,
            onChanged: onChecked,
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
          Text(caption,
              style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
      if(selectedMeal!=null)...[
        ActiveMealCard.edit(selectedMeal,
        onChange: ()=>AppNavigator.pushAndStackPage(context,
            page: const ChooseChowScreen()).then((result){
          _selectMeal(onSelected: onSelected,
              mealType: caption.toLowerCase(),
              result: result);
        }),
        onEdit: ()=>Modals.showBottomSheetModal(context,
            heightFactor: 1.0,
            isScrollControlled: true,
            borderRadius: 25,
            page: ChowDetailDialog(selectedMeal.product))
            .then((result){
          _selectMeal(onSelected: onSelected,
              mealType: caption.toLowerCase(),
              result: result);
        }),
        onRemove: ()=>onSelected(null))
      ]else...[
        InkWell(
          onTap: check? ()=>AppNavigator.pushAndStackPage(context,
              page: const ChooseChowScreen()).then((result){
            _selectMeal(onSelected: onSelected,
                mealType: caption.toLowerCase(),
                result: result);
          }): null,
          child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: SizedBox(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle,
                        color: check ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).iconTheme.color!.withOpacity(0.3)),
                    const SizedBox(width: 15),
                    Text('Choose meal',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: check ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).textTheme.caption!.color))
                  ],
                ),
              )),
        )
      ]
    ],
  );

  void _selectMeal({required ValueChanged<Meal?> onSelected,
  required String mealType, result}){
    if(result!=null){
      final quantity=result[0];
      final date=_plansCubit.viewModel.newPlans[widget.day].planDate;
      final dueTime=AppUtils.timeToDateTime(result[1], date);
      final product=result[2];
      onSelected(Meal(product: product,
          quantity: quantity,
          dueTime: dueTime,
          mealType: mealType));
      return;
    }
  }

}
