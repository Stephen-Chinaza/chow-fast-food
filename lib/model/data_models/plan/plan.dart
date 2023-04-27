import 'dart:convert';

import 'package:chow/utils/app_utils.dart';
import 'package:intl/intl.dart';

import 'meal.dart';

class Plan {
  Plan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.planDate,
    this.meals,
    this.completed,
    this.status,
  });

  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? planDate;
  final List<Meal>? meals;
  final bool? completed;
  final String? status;

  bool get isCompleted=>completed ?? false;

  Plan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? planDate,
    List<Meal>? meals,
    bool? completed,
    String? status,
  }) =>
      Plan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        planDate: planDate ?? this.planDate,
        meals: meals ?? this.meals,
        completed: completed ?? this.completed,
        status: status ?? this.status,
      );

  factory Plan.fromJson(String str) => Plan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    planDate: DateTime.parse(json["plan_date"]),
    meals: List<Meal>.from(json["plan_meal"].map((x) => Meal.fromMap(x))),
    completed: json["completed"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    if(id!=null)"id": id,
    if(createdAt!=null)"created_at": createdAt!.toIso8601String(),
    if(updatedAt!=null)"updated_at": updatedAt!.toIso8601String(),
    if(planDate!=null)"plan_date": DateFormat('yyyy-MM-dd').format(planDate!),
    if(meals!=null)"plan_meal": List<dynamic>.from(meals!.map((x) => x.toMap())),
    if(completed!=null)"completed": completed,
    if(completed!=null)"status": status,
  };

  Map<String, dynamic> toCreationMap() => {
    "plan_date": AppUtils.apiDateFormat.format(planDate!),
    "meals": List<dynamic>.from(meals!.map((x) => x.toCreationMap())),
  };

}