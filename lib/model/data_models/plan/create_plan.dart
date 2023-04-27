import 'dart:convert';

import 'plan.dart';

class CreatePlan {
  CreatePlan({
    required this.items,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.duration,
    required this.paymentMethod
  });

  final List<Plan> items;
  final String latitude;
  final String longitude;
  final String location;
  final String duration;
  final String paymentMethod;

  CreatePlan copyWith({
    List<Plan>? items,
    String? latitude,
    String? longitude,
    String? location,
    String? duration,
    String? paymentMethod,
  }) =>
      CreatePlan(
        items: items ?? this.items,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        duration: duration ?? this.duration,
        paymentMethod: paymentMethod ?? this.paymentMethod,
      );

  factory CreatePlan.fromJson(String str) => CreatePlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePlan.fromMap(Map<String, dynamic> json) => CreatePlan(
    items: List<Plan>.from(json["items"].map((x) => Plan.fromMap(x))),
    latitude: json["latitude"],
    longitude: json["longitude"],
    location: json["location"],
    duration: json["plan_duration_type"],
    paymentMethod: json["payment_method"]
  );

  Map<String, dynamic> toMap() => {
    "items": List<dynamic>.from(items.map((x) => x.toCreationMap())),
    "latitude": latitude,
    "longitude": longitude,
    "location": location,
    "payment_method": paymentMethod,
    "plan_duration_type": duration
  };
}
