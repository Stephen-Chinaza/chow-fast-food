import 'dart:convert';

import '../user/customer.dart';
import 'plan.dart';

class MealPlan {
  MealPlan({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.amount,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.paid,
    required this.isCancelled,
    required this.shippingFee,
    required this.paymentUrl,
    required this.plan,
    required this.completed
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Customer customer;
  final int amount;
  final String status;
  final String latitude;
  final String longitude;
  final String location;
  final bool paid;
  final bool isCancelled;
  final int shippingFee;
  final String? paymentUrl;
  final List<Plan> plan;
  final bool? completed;

  bool get isCompleted=> completed ?? false;

  MealPlan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Customer? customer,
    int? amount,
    String? status,
    String? latitude,
    String? longitude,
    String? location,
    bool? paid,
    bool? isCancelled,
    int? shippingFee,
    String? paymentUrl,
    List<Plan>? plan,
    bool? completed
  }) =>
      MealPlan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customer: customer ?? this.customer,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        paid: paid ?? this.paid,
        isCancelled: isCancelled ?? this.isCancelled,
        shippingFee: shippingFee ?? this.shippingFee,
        paymentUrl: paymentUrl ?? this.paymentUrl,
        plan: plan ?? this.plan,
        completed: completed ?? this.completed
      );

  factory MealPlan.fromJson(String str) => MealPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MealPlan.fromMap(Map<String, dynamic> json) => MealPlan(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customer: Customer.fromMap(json["customer"]),
    amount: json["amount"],
    status: json["status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    location: json["location"],
    paid: json["paid"],
    isCancelled: json["is_cancelled"],
    shippingFee: json["shipping_fee"],
    paymentUrl: json["payment_url"],
    plan: List<Plan>.from(json["plan"].map((x) => Plan.fromMap(x))),
    completed: json["completed"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "customer": customer.toMap(),
    "amount": amount,
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
    "location": location,
    "paid": paid,
    "is_cancelled": isCancelled,
    "shipping_fee": shippingFee,
    "payment_url": paymentUrl,
    "plan": List<dynamic>.from(plan.map((x) => x.toMap())),
    "completed": completed,
  };
}
