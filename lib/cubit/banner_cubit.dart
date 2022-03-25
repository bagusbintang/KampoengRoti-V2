import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/banner_model.dart';
import 'package:kampoeng_roti2/services/banner_service.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  void fetchBanner() async {
    try {
      emit(BannerLoading());
      List<BannerModel> banners = await BannerService().getBanner();
      emit(BannerSuccess(banners));
    } catch (e) {
      emit(
        BannerFailed(e.toString()),
      );
    }
  }
}
