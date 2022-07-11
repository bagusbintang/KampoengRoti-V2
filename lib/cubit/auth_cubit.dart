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
      if (user.verified == 1) {
        emit(AuthSuccess(user));
      } else {
        await AuthService().resendOtp(userId: user.id!);
        emit(AuthSuccess(user));
      }
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
      emit(AuthRegisterSuccess(user));
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
      emit(AuthRegisterSuccess(user));
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

  void forgetPassword({
    required String email,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().forgotPassword(email: email);
      emit(AuthForgetPasswordSuccess(user));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }

  void resendOtp({
    required int userId,
  }) async {
    try {
      emit(AuthLoading());
      await AuthService().resendOtp(userId: userId);
      emit(AuthResendOtpSuccess('Resend Berhasil !!'));
    } catch (e) {
      emit(
        AuthOtpFailed(
          e.toString(),
        ),
      );
    }
  }

  void submitOtp({
    required int userId,
    required int otp,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().submitOtp(userId: userId, otp: otp);
      emit(AuthOtpSuccess(user));
    } catch (e) {
      emit(
        AuthOtpFailed(
          e.toString(),
        ),
      );
    }
  }

  void resetPassword({
    required int userId,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().resetPassword(
        userId: userId,
        password: password,
      );
      emit(AuthResetPasswordSuccess(user));
    } catch (e) {
      emit(
        AuthFailed(
          e.toString(),
        ),
      );
    }
  }
}
