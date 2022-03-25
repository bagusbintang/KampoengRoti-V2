import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/services/order_service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void order({
    required int userId,
    required int deliveryMethod,
    int? addressId,
    required int outletId,
    required int promoId,
    required double shippingCosts,
    required double promoDisc,
    required double memberDisc,
    required String deliveryTime,
    required String paymenMethod,
    required String note,
    required double total,
    required double grandTotal,
  }) async {
    try {
      emit(OrderLoading());
      await OrderService().checkOut(
        userId: userId,
        deliveryMethod: deliveryMethod,
        addressId: addressId,
        outletId: outletId,
        promoId: promoId,
        shippingCosts: shippingCosts,
        promoDisc: promoDisc,
        memberDisc: memberDisc,
        deliveryTime: deliveryTime,
        paymenMethod: paymenMethod,
        note: note,
        total: total,
        grandTotal: grandTotal,
      );
      emit(OrderSuccess());
    } catch (e) {
      emit(
        OrderFailed(e.toString()),
      );
    }
  }
}
