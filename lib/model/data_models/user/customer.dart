import 'dart:convert';

import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String location;
  final double latitude;
  final double longitude;

  Customer copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? location,
    double? latitude,
    double? longitude,
  }) =>
      Customer(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  List<Object?> get props =>
      [firstName, lastName, phoneNumber, location, latitude, longitude];
}
