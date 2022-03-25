import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/promo_model.dart';
import 'package:kampoeng_roti2/services/promo_service.dart';

part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  PromoCubit() : super(PromoInitial());

  void fetchPromo({required int userId}) async {
    try {
      emit(PromoLoading());
      List<PromoModel> promoList =
          await PromoService().getPromo(userId: userId);
      emit(PromoSuccess(promoList));
    } catch (e) {
      emit(
        PromoFailed(e.toString()),
      );
    }
  }
}
