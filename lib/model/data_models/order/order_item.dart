import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../product/product.dart';

class OrderItem extends Equatable {
  const OrderItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.quantity,
    required this.totalCost,
    required this.status,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;
  final int quantity;
  final double totalCost;
  final String status;

  OrderItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
    int? quantity,
    double? totalCost,
    String? status,
  }) =>
      OrderItem(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        totalCost: totalCost ?? this.totalCost,
        status: status ?? this.status,
      );

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromMap(json["product"]),
        quantity: json["quantity"] ?? 0,
        totalCost: json["total_cost"] is int
            ? json["total_cost"].toDouble()
            : json["total_cost"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
        "quantity": quantity,
        "total_cost": totalCost,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        product,
        quantity,
        totalCost,
        status,
      ];
}
