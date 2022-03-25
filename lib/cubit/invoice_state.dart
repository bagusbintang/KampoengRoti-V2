part of 'invoice_cubit.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {
  final List<InvoiceModel> invoice;
  InvoiceSuccess(this.invoice);
  @override
  // TODO: implement props
  List<Object> get props => [invoice];
}

class InvoiceFailed extends InvoiceState {
  final String error;
  InvoiceFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
