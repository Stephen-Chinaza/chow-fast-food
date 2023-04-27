import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartInfo extends Equatable {
  const CartInfo({
    required this.productId,
    this.quantity,
    this.percentageComposition,
    this.proteinOption,
  });

  final String productId;
  final int? quantity;
  final int? percentageComposition;
  final String? proteinOption;

  CartInfo copyWith({
    String? productId,
    int? quantity,
    int? percentageComposition,
    String? proteinOption,
  }) =>
      CartInfo(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        percentageComposition:
            percentageComposition ?? this.percentageComposition,
        proteinOption: proteinOption ?? this.proteinOption,
      );

  factory CartInfo.fromJson(String str) => CartInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartInfo.fromMap(Map<String, dynamic> json) => CartInfo(
        productId: json["product_id"],
        quantity: json["quantity"],
        percentageComposition: json["percentage_composition"],
        proteinOption: json["protein_option"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        if(quantity!=null)"quantity": quantity,
        if(percentageComposition!=null) "percentage_composition": percentageComposition,
        if(proteinOption!=null)"protein_option": proteinOption,
      };

  @override
  List<Object?> get props =>
      [productId, quantity, percentageComposition, proteinOption];
}
