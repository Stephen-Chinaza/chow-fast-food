import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../res/enum.dart';
import '../image.dart';
import '../product/product.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    required this.phoneNumber,
    required this.countryCode,
    required this.userClass,
    required this.isBlocked,
    required this.accountVerified,
    this.timezone,
    this.location,
    this.latitude,
    this.longitude,
    required this.pinCreated,
    required this.accountType,
    required this.kycVerified,
    required this.kycSubmitted,
    this.picture,
    this.businessName,
    this.businessVerified,
    this.product,
    this.state,
    this.city,
    this.businessRegistered,
    this.rcBnNumber,
    this.productCategory,
  });

  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String phoneNumber;
  final String? countryCode;
  final String userClass;
  final bool isBlocked;
  final bool accountVerified;
  final String? timezone;
  final String? location;
  final String? latitude;
  final String? longitude;
  final bool pinCreated;
  final String accountType;
  final bool kycVerified;
  final bool kycSubmitted;
  final Image? picture;
  final String? businessName;
  final bool? businessVerified;
  final List<Product>? product;
  final String? state;
  final String? city;
  final bool? businessRegistered;
  final String? rcBnNumber;
  final String? productCategory;

  String get phone {
    String mobile = phoneNumber.startsWith('0')
        ? phoneNumber.replaceFirst('0', '')
        : phoneNumber;
    return '$countryCode$mobile';
  }

  VerificationStatus get verificationStatus {
    if (kycVerified) {
      return VerificationStatus.verified;
    } else if (kycSubmitted) {
      return VerificationStatus.pending;
    } else {
      return VerificationStatus.none;
    }
  }

  String get emailTitle => email != null ? 'Edit' : 'Add';

  String get userEmail => email ?? 'No Email added';

  String get password => '*******';

  String get image => picture != null ? picture!.url : '';

  User copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? countryCode,
    String? userClass,
    bool? isBlocked,
    bool? accountVerified,
    String? timezone,
    String? location,
    String? latitude,
    String? longitude,
    bool? pinCreated,
    String? accountType,
    bool? kycVerified,
    bool? kycSubmitted,
    Image? picture,
    String? businessName,
    bool? businessVerified,
    List<Product>? product,
    final String? state,
    final String? city,
    final bool? businessRegistered,
    final String? rcBnNumber,
    final String? productCategory,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        countryCode: countryCode ?? this.countryCode,
        userClass: userClass ?? this.userClass,
        isBlocked: isBlocked ?? this.isBlocked,
        accountVerified: accountVerified ?? this.accountVerified,
        timezone: timezone ?? this.timezone,
        location: location ?? this.location,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        pinCreated: pinCreated ?? this.pinCreated,
        accountType: accountType ?? this.accountType,
        kycSubmitted: kycSubmitted ?? this.kycSubmitted,
        kycVerified: kycVerified ?? this.kycVerified,
        picture: picture ?? this.picture,
        businessName: businessName ?? this.businessName,
        businessVerified: businessVerified ?? this.businessVerified,
        product: product ?? this.product,
        state: state ?? this.state,
        city: city ?? this.city,
        businessRegistered: businessRegistered ?? this.businessRegistered,
        rcBnNumber: rcBnNumber ?? this.rcBnNumber,
        productCategory: productCategory ?? this.productCategory,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        userClass: json["user_class"],
        isBlocked: json["is_blocked"],
        accountVerified: json["account_verified"],
        timezone: json["timezone"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pinCreated: json["pin_created"],
        accountType: json["account_type"],
        kycSubmitted: json["kyc_submitted"],
        kycVerified: json["kyc_verified"],
        picture:
            json['picture'] != null ? Image.fromMap(json['picture']) : null,
        businessName: json["business_name"],
        businessVerified: json["business_verified"],
        product: json["product"] != null
            ? List<Product>.from(json["product"].map((x) => Product.fromMap(x)))
            : null,
        state: json['state'],
        city: json['city'],
        productCategory: json['product_category'],
        businessRegistered: json['business_registered'],
        rcBnNumber: json['rc_bn_number'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "user_class": userClass,
        "is_blocked": isBlocked,
        "account_verified": accountVerified,
        "timezone": timezone,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "pin_created": pinCreated,
        "account_type": accountType,
        "kyc_submitted": kycSubmitted,
        "kyc_verified": kycVerified,
        "picture": picture != null ? picture!.toMap() : null,
        "business_name": businessName,
        "business_verified": businessVerified,
        "product":
            product != null ? List<dynamic>.from(product!.map((x) => x)) : null,
        "state": state,
        "city": city,
        "product_category": productCategory,
        "business_registered": businessRegistered,
        "rc_bn_number": rcBnNumber,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        email,
        firstName,
        lastName,
        phoneNumber,
        countryCode,
        userClass,
        isBlocked,
        accountVerified,
        timezone,
        location,
        latitude,
        longitude,
        pinCreated,
        accountType,
        kycSubmitted,
        kycVerified,
        businessName,
        businessVerified,
        product,
        state,
        city,
        productCategory,
        businessRegistered,
        rcBnNumber,
      ];
}
