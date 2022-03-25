import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/services/outlet_service.dart';

part 'outlet_state.dart';

class OutletCubit extends Cubit<OutletState> {
  OutletCubit() : super(OutletInitial());

  void fetchOutlet({
    int cityId = 1,
    required double latitude,
    required double longitude,
  }) async {
    try {
      emit(OutletLoading());
      List<OutletModel> outlets = await OutletService().getOutlets(
        cityId: cityId,
        latitude: latitude,
        longitude: longitude,
      );
      emit(OutletSuccess(outlets));
    } catch (e) {
      emit(
        OutletFailed(e.toString()),
      );
    }
  }
}
