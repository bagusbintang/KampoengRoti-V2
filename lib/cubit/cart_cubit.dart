import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/services/cart_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void fetchCart({
    required int userId,
  }) async {
    try {
      emit(CartLoading());
      List<CartModel> carts = await CartService().getCart(userId: userId);
      emit(CartSuccess(carts));
    } catch (e) {
      emit(
        CartFailed(e.toString()),
      );
    }
  }

  void addCart({
    required int userId,
    required int productId,
    required int outletId,
    int quantity = 1,
  }) async {
    try {
      emit(CartLoading());
      await CartService().addCart(
        userId: userId,
        prodId: productId,
        outletId: outletId,
        quantity: quantity,
      );
      List<CartModel> carts = await CartService().getCart(userId: userId);
      emit(CartSuccess(carts));
    } catch (e) {
      print(e);
      emit(
        CartFailed(e.toString()),
      );
    }
  }

  void saveEditCart({required List<CartModel> carts}) {
    try {
      emit(CartLoading());
      carts.forEach((cart) async {
        await CartService().editCart(
          cartId: cart.id!,
          quantity: cart.quantity!,
          notes: cart.notes ?? "",
        );
      });
      emit(CartSuccess(carts));
    } catch (e) {
      emit(
        CartFailed(e.toString()),
      );
    }
  }

  void deleteCart({required int id, required int userId}) async {
    try {
      emit(CartLoading());
      await CartService().deleteCart(
        cartId: id,
      );
      List<CartModel> carts = await CartService().getCart(userId: userId);
      emit(CartSuccess(carts));
    } catch (e) {
      emit(
        CartFailed(e.toString()),
      );
    }
  }

  // totalItem() {
  //   int total = 0;
  //   for (var item in state.props[0]) {
  //     // total += item as int;
  //     print(item);
  //   }
  //   return total;
  // }
  // totalPrice() {
  //   double total = 0;
  //   for (var item in state.props) {
  //     total += (item.quantity * item.prodPrice);
  //   }

  //   return total;
  // }

  totalCart() {
    return state.props.length;
  }
}
