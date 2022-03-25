part of 'promo_cubit.dart';

abstract class PromoState extends Equatable {
  const PromoState();

  @override
  List<Object> get props => [];
}

class PromoInitial extends PromoState {}

class PromoLoading extends PromoState {}

class PromoSuccess extends PromoState {
  final List<PromoModel> promoList;
  PromoSuccess(this.promoList);
  @override
  // TODO: implement props
  List<Object> get props => [promoList];
}

class PromoFailed extends PromoState {
  final String error;
  PromoFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
