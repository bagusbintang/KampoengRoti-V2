import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/invoice_model.dart';
import 'package:kampoeng_roti2/services/order_service.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  void fetchInvoice({
    required int userId,
    required int status,
  }) async {
    try {
      emit(InvoiceLoading());
      List<InvoiceModel> invoices =
          await OrderService().getInvoice(userId: userId, status: status);
      emit(InvoiceSuccess(invoices));
    } catch (e) {
      emit(
        InvoiceFailed(e.toString()),
      );
    }
  }
}
