import 'package:chow/model/data_models/plan/meal_plan.dart';
import 'package:chow/res/enum.dart';
import 'package:chow/utils/app_utils.dart';

import '../data_models/plan/meal.dart';
import '../data_models/plan/plan.dart';
import 'base_viewmodel.dart';

class MealPlanViewModel extends BaseViewModel {

  List<MealPlan> _activeMealPlans=[];

  List<MealPlan> _expiredMealPlans=[];


  late String _duration;
  List<int> _selectedDays=[];
  final List<Plan> _newPlans=[];

  List<Plan> get newPlans=>_newPlans;

  List<MealPlan> get activeMealPlans=>_activeMealPlans;

  List<MealPlan> get completedMealPlans=>_activeMealPlans.where((m) => m.isCompleted==true).toList();

  List<MealPlan> get inProgressMealPlans=>_activeMealPlans.where((m) => m.isCompleted==false).toList();

  List<MealPlan> get expiredMealPlans=>_expiredMealPlans;

  String get duration => _duration.toLowerCase();


  int get totalDays{
    int days=0;
    for (MealPlan m in activeMealPlans) {
      days+=m.plan.length;
    }
    return days;
  }

  int get daysLeft{
    int days=0;
    for (MealPlan m in activeMealPlans) {
      for (Plan p in m.plan) {
        if(!p.isCompleted)days++;
      }
    }
    return days;
  }

  int get daysCompleted{
    int days=0;
    for (MealPlan m in activeMealPlans) {
      for (Plan p in m.plan) {
        if(p.isCompleted)days++;
      }
    }
    return days;
  }

  double get progressPercentage{
    return (daysCompleted/totalDays)*100;
  }

  List<String> get dayCount{
    List<String> days=[];
    for(int i=1; i<=_newPlans.length; i++){
      days.add('DAY $i');
    }
    return days;
  }

  List<String> get dayOfWeek{
    List<String> days=[];
    for (Plan plan in _newPlans) {
      days.add(AppUtils.dayOfWeekFormat.format(plan.planDate!));
    }
    return days;
  }

  double dailyMealTotalPrice(int index){
    double price=0;
    final plan=newPlans[index];
    for (Meal m in plan.meals!) {
      price+=double.parse(m.product.price);
    }
    return price;
  }

  double get planTotalPrice{
    double price=0;
    for (Plan p in newPlans) {
      for (Meal m in p.meals!) {
        price+=(double.parse(m.product.price)*m.quantity);
      }
    }
    return price;
  }

  void setPlan(String duration, [List<int>? days]){
    _duration=duration;
    if(days!=null)_selectedDays=days;
    setViewState(ViewState.success);
  }

  void setPlanDate(DateTime startDate){
    _newPlans.clear();
    switch(_duration){
      case 'Daily':
        {
          _newPlans.add(Plan(
              planDate: startDate
          ));
          break;
        }
      case 'Weekly':
        {
          for(int i=0; i<7; i++){
            _newPlans.add(Plan(
                planDate: startDate.add(Duration(days: i))
            ));
          }
          break;
        }
      case 'Monthly':
        {
          for(int i=0; i<_getNumberOfDaysInMonth(startDate.month); i++){
            _newPlans.add(Plan(
                planDate: startDate.add(Duration(days: i))
            ));
          }
          break;
        }
      case 'Custom':
        {
          for (int selectedDay in _selectedDays) {
            for(int i=0; i<7; i++){
              final day=startDate.add(Duration(days: i));
              if(day.weekday==selectedDay+1){
                _newPlans.add(Plan(
                    planDate: day
                ));
              }
            }
          }
          break;
        }
    }
  }

  void setDailyMeals(List<Meal> meals, {required int index}){
    _newPlans[index]=_newPlans[index].copyWith(meals: meals);
    setViewState(ViewState.success);
  }

  void setActiveMealPlans(List<MealPlan> plans){
    _activeMealPlans=plans;
    setViewState(ViewState.success);
  }

  void setExpiredMealPlans(List<MealPlan> plans){
    _expiredMealPlans=plans;
    setViewState(ViewState.success);
  }

  int _getNumberOfDaysInMonth(int month){
    switch (month){
      case DateTime.september:
      case DateTime.april:
      case DateTime.june:
      case DateTime.november:
        return 30;
      case DateTime.february:
        return 28;
      default:
        return 31;
    }
  }

  String activePlanCaption(Plan plan){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);


    final dateToCheck = plan.planDate!;
    final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if(aDate == today) {
    return 'Today’s Plan';
    } else if(aDate == tomorrow) {
    return 'Tomorrow’s Plan';
    } else{
    return '${AppUtils.dayOfWeekFormat.format(dateToCheck)}’s Plan';
    }
  }

}
