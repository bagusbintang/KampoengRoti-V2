part of 'outlet_cubit.dart';

abstract class OutletState extends Equatable {
  const OutletState();

  @override
  List<Object> get props => [];
}

class OutletInitial extends OutletState {}

class OutletLoading extends OutletState {}

class OutletSuccess extends OutletState {
  final List<OutletModel> outlets;

  OutletSuccess(this.outlets);
  @override
  // TODO: implement props
  List<Object> get props => [outlets];
}

class OutletFailed extends OutletState {
  final String error;

  OutletFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
