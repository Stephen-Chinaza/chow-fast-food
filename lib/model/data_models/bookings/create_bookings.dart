import 'dart:convert';

import 'package:chow/model/data_models/user/user.dart';
import 'package:equatable/equatable.dart';

import '../order/get_order.dart';

class CreateBooking extends Equatable {
  const CreateBooking({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingFrom,
    required this.bookingTo,
    required this.order,
    required this.bookingToPhone,
    required this.comment,
    required this.paid,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User bookingFrom;
  final User bookingTo;
  final GetOrder order;
  final String bookingToPhone;
  final String comment;
  final bool paid;

  factory CreateBooking.fromJson(String str) =>
      CreateBooking.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateBooking.fromMap(Map<String, dynamic> json) => CreateBooking(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingFrom: User.fromMap(json["booking_from"]),
        bookingTo: User.fromMap(json["booking_to"]),
        order: GetOrder.fromMap(json["order"]),
        bookingToPhone: json["booking_to_phone"],
        comment: json["comment"],
        paid: json["paid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "booking_from": bookingFrom.toJson(),
        "booking_to": bookingTo.toJson(),
        "order": order.toJson(),
        "booking_to_phone": bookingToPhone,
        "comment": comment,
        "paid": paid,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        bookingFrom,
        bookingTo,
        order,
        bookingToPhone,
        comment,
        paid,
      ];
}
