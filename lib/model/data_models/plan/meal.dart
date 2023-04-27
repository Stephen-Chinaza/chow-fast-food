import 'dart:convert';

import '../product/product.dart';

class Meal {
  Meal({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.product,
    required this.quantity,
    required this.dueTime,
    required this.mealType,
    this.completed,
    this.status
  });

  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product product;
  final int quantity;
  final DateTime dueTime;
  final String mealType;
  final bool? completed;
  final String? status;

  Meal copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
    int? quantity,
    DateTime? dueTime,
    String? mealType,
    bool? completed,
    String? status,
  }) =>
      Meal(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        dueTime: dueTime ?? this.dueTime,
        mealType: mealType ?? this.mealType,
        completed: completed ?? this.completed,
        status: status ?? this.status,
      );

  factory Meal.fromJson(String str) => Meal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromMap(json["product"]),
    quantity: json["quantity"],
    dueTime: DateTime.parse(json["due_time"]),
    mealType: json["meal_type"],
    completed: json["completed"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    if(id!=null)"id": id,
    if(createdAt!=null)"created_at": createdAt!.toIso8601String(),
    if(updatedAt!=null)"updated_at": updatedAt!.toIso8601String(),
    "product": product.toMap(),
    "quantity": quantity,
    "due_time": dueTime.toIso8601String(),
    "meal_type": mealType,
    if(completed!=null)"completed": completed,
    if(status!=null)"status": status,
  };

  Map<String, dynamic> toCreationMap() => {
    "product_id": product.id,
    "quantity": quantity,
    "meal_type": mealType,
    "due_time": dueTime.toUtc().toIso8601String(),
  };

}