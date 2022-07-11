import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/contact_us_model.dart';
import 'package:kampoeng_roti2/services/contact_us_service.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void getContact() async {
    try {
      emit(ContactLoading());
      ContactUsModel contact = await ContactUsService().getCcontact();
      emit(ContactSuccess(contact));
    } catch (e) {
      emit(
        ContactFailed(
          e.toString(),
        ),
      );
    }
  }
}
