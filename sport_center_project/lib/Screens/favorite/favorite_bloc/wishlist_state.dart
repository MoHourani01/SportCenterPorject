import 'package:equatable/equatable.dart';
import 'package:sport_center_project/Screens/favorite/favorite_bloc/wishlist_model.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistLoading extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistLoaded extends WishlistState {
  final Wishlist wishlist;
  const WishlistLoaded({required this.wishlist});

  @override
  List<Object?> get props => [wishlist];
}

class WishlistError extends WishlistState {
  @override
  List<Object?> get props => [];
}