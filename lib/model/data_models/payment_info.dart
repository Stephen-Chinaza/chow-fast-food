import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentInfo extends Equatable {
  const PaymentInfo({
    this.paymentUrl,
    this.orderId,
  });

  final String? paymentUrl;
  final String? orderId;

  PaymentInfo copyWith({
    String? paymentUrl,
    String? orderId,
  }) =>
      PaymentInfo(
        paymentUrl: paymentUrl ?? this.paymentUrl,
        orderId: orderId ?? this.orderId,
      );

  factory PaymentInfo.fromJson(String str) =>
      PaymentInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInfo.fromMap(Map<String, dynamic> json) => PaymentInfo(
        paymentUrl: json["payment_url"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toMap() => {
        "payment_url": paymentUrl,
        "order_id": orderId,
      };

  @override
  List<Object?> get props => [paymentUrl, orderId];
}
