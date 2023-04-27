import 'package:chow/model/data_models/plan/create_plan.dart';
import 'package:chow/model/view_models/meal_plan_view_model.dart';
import 'package:chow/requests/repositories/meal_plan_repository/meal_plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/data_models/plan/meal.dart';
import '../../utils/exceptions.dart';
import 'plans_states.dart';

class PlansCubit extends Cubit<PlansStates> {
  PlansCubit({required this.viewModel, required this.mealPlanRepository})
      : super(const InitialState());

  final MealPlanRepository mealPlanRepository;
  final MealPlanViewModel viewModel;

  Future<void> createMealPlan(CreatePlan plan) async {
    try {
      emit(MealPlansProcessing());

      final paymentInfo = await mealPlanRepository.createMealPlan(plan);

      emit(MealPlanCreated(paymentInfo, plan.paymentMethod));
      getActiveMealPlans();
    } on ApiException catch (e) {
      emit(MealPlansApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MealPlansNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getActiveMealPlans() async {
    try {
      emit(MealPlansLoading());

      final plans = await mealPlanRepository.getActiveMealPlans();

      viewModel.setActiveMealPlans(plans);
      emit(MealPlansLoaded(plans));
    } on ApiException catch (e) {
      emit(MealPlansApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MealPlansNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getExpiredMealPlans() async {
    try {
      emit(MealPlansLoading());

      final plans = await mealPlanRepository.getExpiredMealPlans();

      viewModel.setExpiredMealPlans(plans);
      emit(MealPlansLoaded(plans));
    } on ApiException catch (e) {
      emit(MealPlansApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(MealPlansNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> setDailyPlan(List<Meal> meals, {required int day}) async {
    viewModel.setDailyMeals(meals, index: day);
    emit(DailyPlanSet(day + 1));
  }
}
