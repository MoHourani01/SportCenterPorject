import 'package:equatable/equatable.dart';
import 'package:sport_center_project/models/product_model.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class StartWishlist extends WishlistEvent {}

class AddWishlistProduct extends WishlistEvent {
  final ProductsModel products;

  AddWishlistProduct(this.products);

  @override
  List<Object?> get props => [products];
}

class RemoveWishlistProduct extends WishlistEvent {
  final ProductsModel products;

  RemoveWishlistProduct(this.products);

  @override
  List<Object?> get props => [products];
}