import 'package:equatable/equatable.dart';

import 'product.dart';

class Cart extends Equatable {
  const Cart({required this.items, required this.cartCost});

  final List<Items> items;
  final double cartCost;

  Cart copyWith({
    List<Items>? items,
    double? cartCost,
  }) =>
      Cart(
        items: items ?? this.items,
        cartCost: cartCost ?? this.cartCost,
      );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        items: List<Items>.from(json["items"].map((x) => Items.fromJson(x))),
        cartCost: json['cart_cost'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = items.map((v) => v.toJson()).toList();
    data['cart_cost'] = cartCost;
    return data;
  }

  @override
  List<Object?> get props => [items, cartCost];
}

class Items {
  final Product? product;
  var quantity;
  final double totalCost;

  Items(
      {required this.product, required this.quantity, required this.totalCost});

  Items copyWith({
    Product? product,
    var quantity,
    double? totalCost,
  }) =>
      Items(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        totalCost: totalCost ?? this.totalCost,
      );

  factory Items.fromJson(Map<String, dynamic> json) => Items(
      product:
          json['product'] != null ? Product.fromMap(json['product']) : null,
      quantity: json['quantity'] is int
          ? json['quantity'].toDouble()
          : json['quantity'],
      totalCost: json['total_cost'] is int
          ? json['total_cost'].toDouble()
          : json['total_cost']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product?.toMap();
    data['quantity'] = quantity;
    data['total_cost'] = totalCost;
    return data;
  }
}
