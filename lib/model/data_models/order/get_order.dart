import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../user/customer.dart';
import 'order_item.dart';

class GetOrder extends Equatable {
  const GetOrder({
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
    required this.orderItem,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Customer customer;
  final int amount;
  final String status;
  final double latitude;
  final double longitude;
  final String location;
  final bool paid;
  final bool isCancelled;
  final int shippingFee;
  final String? paymentUrl;
  final List<OrderItem> orderItem;

  GetOrder copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Customer? customer,
          int? amount,
          String? status,
          double? latitude,
          double? longitude,
          String? location,
          bool? paid,
          bool? isCancelled,
          int? shippingFee,
          String? paymentUrl,
          List<OrderItem>? orderItem}) =>
      GetOrder(
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
        orderItem: orderItem ?? this.orderItem,
      );

  factory GetOrder.fromJson(String str) => GetOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOrder.fromMap(Map<String, dynamic> json) => GetOrder(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromMap(json["customer"]),
        amount:
            json["amount"] is double ? json["amount"].toInt() : json["amount"],
        status: json["status"],
        latitude: json["latitude"] is String
            ? double.parse(json["latitude"])
            : json["latitude"],
        longitude: json["longitude"] is String
            ? double.parse(json["longitude"])
            : json["longitude"],
        location: json["location"],
        paid: json["paid"],
        isCancelled: json["is_cancelled"],
        shippingFee: json["shipping_fee"],
        paymentUrl: json["payment_url"],
        orderItem: List<OrderItem>.from(
            json["order_item"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "customer": customer.toJson(),
        "amount": amount,
        "status": status,
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "paid": paid,
        "is_cancelled": isCancelled,
        "shipping_fee": shippingFee,
        "payment_url": paymentUrl,
        "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        customer,
        amount,
        status,
        latitude,
        longitude,
        location,
        paid,
        isCancelled,
        shippingFee,
        paymentUrl,
        orderItem,
      ];
}
