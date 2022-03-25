import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String username,
    required String email,
    required String phone,
    required String password,
    required double lat,
    required double long,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().register(
        username: username,
        email: email,
        phone: phone,
        password: password,
        lat: lat,
        long: long,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void editProfile({
    required int userId,
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().updateProfile(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void registerMember({
    required int userId,
    required File imageFile,
    required String name,
    required String address,
    required String birthdate,
    required String noKtp,
  }) async {
    try {
      emit(AuthLoading());
      await AuthService().registerMember(
        userId: userId,
        imageFile: imageFile,
        name: name,
        address: address,
        birthdate: birthdate,
        noKtp: noKtp,
      );
      UserModel user = await AuthService().refreshUser(userId: userId);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void refreshUser({
    required int id,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().refreshUser(userId: id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void registMemberNo({
    required int userId,
    required String memberNo,
  }) async {
    try {
      emit(AuthLoading());
      String string = await AuthService().registerMemberNo(
        // username: username,
        userId: userId, memberNo: memberNo,
      );

      print(string);
      UserModel user = await AuthService().refreshUser(userId: userId);
      emit(AuthSuccess(user));
    } catch (e) {
      print(e);
      emit(AuthFailed(e.toString()));
    }
  }
}
