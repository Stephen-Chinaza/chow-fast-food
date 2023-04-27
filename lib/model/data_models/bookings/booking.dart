import 'dart:convert';

import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  const Booking({
    this.paymentUrl,
    this.orderId,
  });

  final String? paymentUrl;
  final String? orderId;

  Booking copyWith({
    String? paymentUrl,
    String? orderId,
  }) =>
      Booking(
        paymentUrl: paymentUrl ?? this.paymentUrl,
        orderId: orderId ?? this.orderId,
      );

  factory Booking.fromJson(String str) => Booking.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        paymentUrl: json["payment_url"],
        orderId: json["booking_id"],
      );

  Map<String, dynamic> toMap() => {
        "payment_url": paymentUrl,
        "order_id": orderId,
      };

  @override
  List<Object?> get props => [paymentUrl, orderId];
}
