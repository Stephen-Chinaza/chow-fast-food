import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../product/product.dart';
import '../user/customer.dart';
import 'get_order.dart';

class TrackUserOrder extends Equatable {
  const TrackUserOrder({
    required this.order,
    required this.notifications,
  });

  final GetOrder order;
  final List<Notification> notifications;

  factory TrackUserOrder.fromJson(String str) =>
      TrackUserOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrackUserOrder.fromMap(Map<String, dynamic> json) => TrackUserOrder(
        order: GetOrder.fromJson(json["order"]),
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "order": order.toJson(),
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [order, notifications];
}

class Notification {
  Notification({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.status,
    required this.extraInfo,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String status;
  String extraInfo;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        extraInfo: json["extra_info"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "extra_info": extraInfo,
      };
}
