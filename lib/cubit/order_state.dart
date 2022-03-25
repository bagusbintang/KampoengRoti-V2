part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailed extends OrderState {
  final String error;
  OrderFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
