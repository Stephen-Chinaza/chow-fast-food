import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user.dart';

class UserData extends Equatable {
  const UserData(
      {required this.accessToken,
      required this.tokenType,
      this.isLoggedIn,
      required this.user});

  final String accessToken;
  final String tokenType;
  final bool? isLoggedIn;
  final User user;

  UserData copyWith(
          {String? accessToken,
          String? tokenType,
          bool? isLoggedIn,
          User? user}) =>
      UserData(
          accessToken: accessToken ?? this.accessToken,
          tokenType: tokenType ?? this.tokenType,
          isLoggedIn: isLoggedIn ?? this.isLoggedIn,
          user: user ?? this.user);

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        isLoggedIn: json["access_token"] != null,
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user.toMap(),
      };

  @override
  List<Object?> get props => [accessToken, tokenType, isLoggedIn, user];
}
