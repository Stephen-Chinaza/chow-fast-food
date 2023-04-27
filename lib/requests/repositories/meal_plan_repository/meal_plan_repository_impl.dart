 import 'package:chow/model/data_models/plan/create_plan.dart';
import 'package:chow/model/data_models/plan/meal_plan.dart';
import 'package:chow/requests/repositories/meal_plan_repository/meal_plan_repository.dart';

import '../../../model/data_models/payment_info.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';

class MealPlanRepositoryImpl implements MealPlanRepository{
  @override
  Future<PaymentInfo> createMealPlan(CreatePlan plan) async{
    final map= await Requests().post(AppStrings.createMealPlanUrl,
        body: plan.toMap());
    return PaymentInfo.fromMap(map);
  }

  @override
  Future<List<MealPlan>> getActiveMealPlans() async{
    final rtn = await Requests().get(AppStrings.getActiveMealPlansUrl);
    return List<MealPlan>.from(rtn.map((x) => MealPlan.fromMap(x)));
  }

  @override
  Future<List<MealPlan>> getExpiredMealPlans() async{
    final rtn = await Requests().get(AppStrings.getExpiredMealPlansUrl);
    return List<MealPlan>.from(rtn.map((x) => MealPlan.fromMap(x)));
  }

}