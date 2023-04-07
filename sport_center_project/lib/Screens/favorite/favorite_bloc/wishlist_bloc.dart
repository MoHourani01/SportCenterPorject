import 'package:bloc/bloc.dart';
import 'package:sport_center_project/Screens/favorite/favorite_bloc/wishlist_event.dart';
import 'package:sport_center_project/Screens/favorite/favorite_bloc/wishlist_model.dart';
import 'package:sport_center_project/Screens/favorite/favorite_bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  WishlistBloc() : super(WishlistLoading());


  // WishlistBloc(super.initialState);

  @override
  Stream<WishlistState> mapEventToState(
      WishlistEvent event,
      )async*{
    if(event is StartWishlist){
      yield* _mapStartWishlistToState();
    }else if(event is AddWishlistProduct){
      yield* _mapAddWishlistProductToState(event, state);
    }else if(event is RemoveWishlistProduct){
      yield* _mapRemoveWishlistProductToState(event, state);
    }
  }
  Stream<WishlistState> _mapStartWishlistToState() async*{
    yield WishlistLoading();
    try{
      await Future<void>.delayed(Duration(seconds: 1));
      yield const WishlistLoaded(wishlist: Wishlist([]));
    }catch(error){}
  }
  Stream<WishlistState> _mapAddWishlistProductToState(
      AddWishlistProduct event,
      WishlistState state,
      )
  async*{
    if(state is WishlistLoaded){
      try{
        yield WishlistLoaded(wishlist: Wishlist(List.from(state.wishlist.products)..add(event.products),),);
      }catch(error){}
    }
  }
  Stream<WishlistState> _mapRemoveWishlistProductToState(
      RemoveWishlistProduct event,
      WishlistState state,
      )
  async*{
    if(state is WishlistLoaded){
      try{
        yield WishlistLoaded(wishlist: Wishlist(List.from(state.wishlist.products)..add(event.products),),);
      }catch(error){}
    }
  }
}