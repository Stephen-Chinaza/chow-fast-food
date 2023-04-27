import 'package:chow/model/data_models/product/cart.dart';
import 'package:equatable/equatable.dart';

import '../../model/data_models/product/product.dart';
import '../../model/data_models/user/user.dart';

abstract class ProductsStates extends Equatable {
  const ProductsStates();
}

class InitialState extends ProductsStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsStates {
  @override
  List<Object> get props => [];
}

class ProductsLoadingMore extends ProductsStates {
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductsStates {
  final List<Product> productsData;
  const ProductsLoaded(this.productsData);
  @override
  List<Object> get props => [productsData];
}

class ProductNetworkErr extends ProductsStates {
  final String? message;
  const ProductNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class ProductApiErr extends ProductsStates {
  final String? message;
  const ProductApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class VendorsLoaded extends ProductsStates {
  final List<User> vendors;
  const VendorsLoaded(this.vendors);

  @override
  List<Object> get props => [vendors];
}

class VendorsNetworkErr extends ProductsStates {
  final String? message;
  const VendorsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class VendorsApiErr extends ProductsStates {
  final String? message;
  const VendorsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SearchLoaded extends ProductsStates {
  final List<Product> productsData;
  const SearchLoaded(this.productsData);
  @override
  List<Object> get props => [productsData];
}

class SearchNetworkErr extends ProductsStates {
  final String? message;
  const SearchNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SearchApiErr extends ProductsStates {
  final String? message;
  const SearchApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CartLoaded extends ProductsStates {
  final List<Items> productsData;
  const CartLoaded(this.productsData);
  @override
  List<Object> get props => [productsData];
}

class CartNetworkErr extends ProductsStates {
  final String? message;
  const CartNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CartApiErr extends ProductsStates {
  final String? message;
  const CartApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
