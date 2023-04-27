import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetSettings extends Equatable {
  const GetSettings({
    required this.specialOffers,
    required this.orderStatus,
    required this.announcement,
    required this.promosAndDeals,
  });

  final bool specialOffers;
  final bool orderStatus;
  final bool announcement;
  final bool promosAndDeals;

  GetSettings copyWith({
    bool? specialOffers,
    bool? orderStatus,
    bool? announcement,
    bool? promosAndDeals,
  }) =>
      GetSettings(
        specialOffers: specialOffers ?? this.specialOffers,
        orderStatus: orderStatus ?? this.orderStatus,
        announcement: announcement ?? this.announcement,
        promosAndDeals: promosAndDeals ?? this.promosAndDeals,
      );

  factory GetSettings.fromJson(String str) =>
      GetSettings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSettings.fromMap(Map<String, dynamic> json) => GetSettings(
        specialOffers: json["special_offers"],
        orderStatus: json["order_status"],
        announcement: json["announcement"],
        promosAndDeals: json["promos_and_deals"],
      );

  Map<String, dynamic> toMap() => {
        "special_offers": specialOffers,
        "order_status": orderStatus,
        "announcement": announcement,
        "promos_and_deals": promosAndDeals,
      };

  @override
  List<Object?> get props => [
        specialOffers,
        orderStatus,
        announcement,
        promosAndDeals,
      ];
}
