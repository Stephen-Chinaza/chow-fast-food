import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../image.dart';
import '../user/user.dart';

class Products extends Equatable {
  const Products({
    required this.products,
    required this.lastIndex,
  });

  final List<Product> products;
  final int lastIndex;

  Products copyWith({
    List<Product>? products,
    int? lastIndex,
  }) =>
      Products(
        products: products ?? this.products,
        lastIndex: lastIndex ?? this.lastIndex,
      );

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
        lastIndex: json["last_index"],
      );

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "last_index": lastIndex,
      };

  @override
  List<Object?> get props => [products, lastIndex];
}

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.price,
    required this.description,
    required this.productType,
    required this.quantity,
    required this.freeDelivery,
    required this.discounted,
    this.discountPercentage,
    required this.category,
    this.sales,
    this.vendor,
    this.preparationTime,
    required this.outOfStock,
  });

  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Image> images;
  final String price;
  final String description;
  final String productType;
  final String quantity;
  final bool freeDelivery;
  final bool discounted;
  final String? discountPercentage;
  final String category;
  final dynamic sales;
  final bool outOfStock;
  final String? preparationTime;
  final User? vendor;

  String get image => images.isNotEmpty ? images.first.url : '';

  Product copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Image>? images,
    String? price,
    String? description,
    String? productType,
    String? quantity,
    bool? freeDelivery,
    bool? discounted,
    String? discountPercentage,
    String? category,
    dynamic sales,
    bool? outOfStock,
    String? preparationTime,
    User? vendor,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        images: images ?? this.images,
        price: price ?? this.price,
        description: description ?? this.description,
        productType: productType ?? this.productType,
        quantity: quantity ?? this.quantity,
        freeDelivery: freeDelivery ?? this.freeDelivery,
        discounted: discounted ?? this.discounted,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        category: category ?? this.category,
        sales: sales ?? this.sales,
        outOfStock: outOfStock ?? this.outOfStock,
        preparationTime: preparationTime ?? this.preparationTime,
        vendor: vendor ?? this.vendor,
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: List<Image>.from(
            json["product_image"].map((x) => Image.fromMap(x))),
        price: json["price"],
        description: json["description"],
        productType: json["product_type"],
        quantity: json["quantity"],
        freeDelivery: json["free_delivery"],
        discounted: json["discounted"],
        discountPercentage: json["discount_percentage"],
        category: json["category"],
        sales: json["sales"],
        outOfStock: json["out_of_stock"],
        preparationTime: json['preparation_time'],
        vendor: json['vendor'] != null ? User.fromMap(json['vendor']) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_image": List<dynamic>.from(images.map((x) => x.toMap())),
        "price": price,
        "description": description,
        "product_type": productType,
        "quantity": quantity,
        "free_delivery": freeDelivery,
        "discounted": discounted,
        "discount_percentage": discountPercentage,
        "category": category,
        "sales": sales,
        "out_of_stock": outOfStock,
        "preparation_time": preparationTime,
        "vendor": vendor,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        updatedAt,
        images,
        price,
        description,
        productType,
        quantity,
        freeDelivery,
        discounted,
        discountPercentage,
        category,
        sales,
        outOfStock,
        preparationTime,
        vendor
      ];
}
