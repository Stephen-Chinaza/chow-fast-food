import 'dart:convert';

class CreateOrder {
  CreateOrder(
      {required this.latitude,
      required this.longitude,
      required this.location,
      required this.paymentMethod});

  final String latitude;
  final String longitude;
  final String location;
  final String paymentMethod;

  CreateOrder copyWith({
    String? latitude,
    String? longitude,
    String? location,
    String? paymentMethod,
  }) =>
      CreateOrder(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        paymentMethod: paymentMethod ?? this.paymentMethod,
      );

  factory CreateOrder.fromJson(String str) =>
      CreateOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateOrder.fromMap(Map<String, dynamic> json) => CreateOrder(
      latitude: json["latitude"],
      longitude: json["longitude"],
      location: json["location"],
      paymentMethod: json["payment_method"]);

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "payment_method": paymentMethod,
      };
}
