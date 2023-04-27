import 'package:equatable/equatable.dart';

import '../user/user.dart';

class Vendor extends Equatable {
  const Vendor({required this.vendors, required this.lastIndex});

  final List<User> vendors;
  final int lastIndex;

  Vendor copyWith({
    List<User>? vendors,
    int? lastIndex,
  }) =>
      Vendor(
        vendors: vendors ?? this.vendors,
        lastIndex: lastIndex ?? this.lastIndex,
      );

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendors: List<User>.from(json["vendors"].map((x) => User.fromMap(x))),
        lastIndex: json["last_index"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendors'] = vendors.map((v) => v.toJson()).toList();
    data['last_index'] = lastIndex;
    return data;
  }

  @override
  List<Object?> get props => [vendors, lastIndex];
}
