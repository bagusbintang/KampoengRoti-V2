part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartModel> carts;
  CartSuccess(this.carts);
  @override
  // TODO: implement props
  List<Object> get props => [carts];
}

class CartSuccessModel extends CartState {
  final CartModel cart;
  CartSuccessModel(this.cart);
  @override
  // TODO: implement props
  List<Object> get props => [cart];
}

class CartFailed extends CartState {
  final String error;
  CartFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
