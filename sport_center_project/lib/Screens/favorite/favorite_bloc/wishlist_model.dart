import 'package:equatable/equatable.dart';
import 'package:sport_center_project/models/product_model.dart';

class Wishlist extends Equatable{
  final List<ProductsModel> products;
  const Wishlist(this.products, );

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}