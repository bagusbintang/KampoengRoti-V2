part of 'faq_cubit.dart';

abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}

class FaqSuccess extends FaqState {
  final List<FaqModel> faqs;
  FaqSuccess(this.faqs);
  @override
  // TODO: implement props
  List<Object> get props => [faqs];
}

class FaqFailed extends FaqState {
  final String error;
  FaqFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
