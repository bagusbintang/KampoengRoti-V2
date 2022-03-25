import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/faq_model.dart';
import 'package:kampoeng_roti2/services/faq_service.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());

  void fetchFaqs() async {
    try {
      emit(FaqLoading());
      List<FaqModel> faqs = await FaqService().getFaq();
      emit(FaqSuccess(faqs));
    } catch (e) {
      emit(
        FaqFailed(e.toString()),
      );
    }
  }
}
