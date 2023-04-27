
import 'package:chow/model/data_models/plan/create_plan.dart';
import 'package:chow/model/data_models/plan/meal_plan.dart';

import '../../../model/data_models/payment_info.dart';

abstract class MealPlanRepository{
  Future<PaymentInfo> createMealPlan(CreatePlan plan);
  Future<List<MealPlan>> getActiveMealPlans();
  Future<List<MealPlan>> getExpiredMealPlans();
}