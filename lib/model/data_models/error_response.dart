import 'dart:convert';

import 'package:equatable/equatable.dart';

class ErrorDetail extends Equatable{
  const ErrorDetail({
    this.loc,
    this.msg,
    this.type,
  });

  final List<String>? loc;
  final String? msg;
  final String? type;

  ErrorDetail copyWith({
    List<String>? loc,
    String? msg,
    String? type,
  }) =>
      ErrorDetail(
        loc: loc ?? this.loc,
        msg: msg ?? this.msg,
        type: type ?? this.type,
      );

  factory ErrorDetail.fromJson(String str) => ErrorDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorDetail.fromMap(Map<String, dynamic> json) => ErrorDetail(
    loc: json["loc"]!=null ? List<String>.from(json["loc"].map((x) => x)) : null,
    msg: json["msg"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "loc": loc!=null ? List<dynamic>.from(loc!.map((x) => x)) : null,
    "msg": msg,
    "type": type,
  };

  @override
  List<Object?> get props => [loc, msg, type];
}
