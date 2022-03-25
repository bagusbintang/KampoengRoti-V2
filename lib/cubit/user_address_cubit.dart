import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/services/user_address_service.dart';

part 'user_address_state.dart';

class UserAddressCubit extends Cubit<UserAddressState> {
  UserAddressCubit() : super(UserAddressInitial());

  void getUserAddress({
    int? userId,
  }) async {
    try {
      emit(UserAddressInitial());
      List<UserAddressModel> address =
          await UserAddressService().getAddress(userId: userId!);
      emit(UserAddressSuccess(address));
    } catch (e) {
      emit(
        UserAddressFailed(e.toString()),
      );
    }
  }

  void addUserAddress({
    int? userId,
    String? tagAddress,
    String? detailAddress,
    String? personPhone,
    String? address,
    String? city,
    String? province,
    String? notes,
    double? latitude,
    double? longitude,
    int? defaultAddress,
  }) async {
    try {
      emit(UserAddressLoading());
      UserAddressModel userAddressModel =
          await UserAddressService().addUserAddress(
        userId: userId,
        tagAddress: tagAddress,
        detailAddress: detailAddress,
        personPhone: personPhone,
        address: address,
        city: city,
        province: province,
        notes: notes,
        latitude: latitude,
        longitude: longitude,
        defaultAddress: defaultAddress,
      );
      emit(UserAddressModelSuccess(userAddressModel));
    } catch (e) {
      emit(
        UserAddressFailed(e.toString()),
      );
    }
  }

  void editUserAddress({
    int? addressId,
    String? tagAddress,
    String? detailAddress,
    String? personPhone,
    String? address,
    String? city,
    String? province,
    String? notes,
    double? latitude,
    double? longitude,
    int? defaultAddress,
  }) async {
    try {
      emit(UserAddressLoading());
      UserAddressModel userAddressModel =
          await UserAddressService().editUserAddress(
        addressId: addressId,
        tagAddress: tagAddress,
        detailAddress: detailAddress,
        personPhone: personPhone,
        address: address,
        city: city,
        province: province,
        notes: notes,
        latitude: latitude,
        longitude: longitude,
        defaultAddress: defaultAddress,
      );
      emit(UserAddressModelSuccess(userAddressModel));
    } catch (e) {
      emit(
        UserAddressFailed(e.toString()),
      );
    }
  }
}
