import 'package:chow/model/data_models/payment_info.dart';
import 'package:equatable/equatable.dart';

import '../../model/data_models/plan/meal_plan.dart';

abstract class PlansStates extends Equatable {
  const PlansStates();
}

class InitialState extends PlansStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class MealPlansLoading extends PlansStates {
  @override
  List<Object> get props => [];
}

class MealPlansProcessing extends PlansStates {
  @override
  List<Object> get props => [];
}

class DailyPlanSet extends PlansStates {
  final int day;
  const DailyPlanSet(this.day);
  @override
  List<Object> get props => [day];
}

class MealPlanCreated extends PlansStates {
  final PaymentInfo info;
  final String paymentMethod;
  const MealPlanCreated(this.info, this.paymentMethod);
  @override
  List<Object> get props => [info, paymentMethod];
}

class MealPlansLoaded extends PlansStates {
  final List<MealPlan> plans;
  const MealPlansLoaded(this.plans);
  @override
  List<Object> get props => [plans];
}

class MealPlansNetworkErr extends PlansStates {
  final String? message;
  const MealPlansNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class MealPlansApiErr extends PlansStates {
  final String? message;
  const MealPlansApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
