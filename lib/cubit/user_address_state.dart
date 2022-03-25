part of 'user_address_cubit.dart';

abstract class UserAddressState extends Equatable {
  const UserAddressState();

  @override
  List<Object> get props => [];
}

class UserAddressInitial extends UserAddressState {}

class UserAddressLoading extends UserAddressState {}

class UserAddressSuccess extends UserAddressState {
  final List<UserAddressModel> address;
  UserAddressSuccess(this.address);

  @override
  // TODO: implement props
  List<Object> get props => [address];
}

class UserAddressModelSuccess extends UserAddressState {
  final UserAddressModel userAddressModel;
  UserAddressModelSuccess(this.userAddressModel);
  @override
  // TODO: implement props
  List<Object> get props => [userAddressModel];
}

class UserAddressFailed extends UserAddressState {
  final String error;
  UserAddressFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
