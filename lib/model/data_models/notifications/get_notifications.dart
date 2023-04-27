import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetNotifications extends Equatable {
  const GetNotifications({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.message,
    required this.read,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String message;
  final bool read;

  GetNotifications copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? message,
    bool? read,
  }) =>
      GetNotifications(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        message: message ?? this.message,
        read: read ?? this.read,
      );

  factory GetNotifications.fromJson(String str) =>
      GetNotifications.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetNotifications.fromMap(Map<String, dynamic> json) =>
      GetNotifications(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"] ?? '',
        message: json["message"],
        read: json["read"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
        "message": message,
        "read": read,
      };

  @override
  List<Object?> get props => [id, createdAt, updatedAt, title, message, read];
}
