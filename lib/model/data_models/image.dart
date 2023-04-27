import 'dart:convert';

import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.filename,
    required this.filesize,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;
  final String filename;
  final String filesize;

  Image copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? url,
    String? filename,
    String? filesize,
  }) =>
      Image(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        url: url ?? this.url,
        filename: filename ?? this.filename,
        filesize: filesize ?? this.filesize,
      );

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        filename: json["filename"],
        filesize: json["filesize"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "filename": filename,
        "filesize": filesize,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, createdAt, updatedAt, url, filename, filesize];
}
