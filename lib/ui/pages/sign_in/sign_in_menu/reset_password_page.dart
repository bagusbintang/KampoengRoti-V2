import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/sign_in/sign_in_pages.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class ResetPasswordPage extends StatefulWidget {
  final int userId;
  const ResetPasswordPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  final TextEditingController newPasswordController =
      TextEditingController(text: '');

  // bool _obscureText = true;

  // Icon _iconPwd = Icon(Icons.remove_red_eye_outlined);

  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //     if (_obscureText) {
  //       _iconPwd = Icon(Icons.remove_red_eye);
  //     } else {
  //       _iconPwd = Icon(Icons.remove_red_eye_outlined);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Widget passwordInput() {
      // bool obscurePwd = true;

      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Password ',
              style: chocolateTextStyle.copyWith(),
            ),
            TextFormField(
              cursorColor: kDarkGreyColor,
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: 'password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: kDarkGreyColor,
                  ),
                  // suffixIcon: IconButton(
                  //   focusColor: kDarkGreyColor,
                  //   onPressed: _toggle,
                  //   icon: _iconPwd,
                  //   color: kChocolateColor,
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  )),
            ),
          ],
        ),
      );
    }

    Widget newPasswordInput() {
      // bool obscurePwd = true;

      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Password ',
              style: chocolateTextStyle.copyWith(),
            ),
            TextFormField(
              cursorColor: kDarkGreyColor,
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: 'confirm password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: kDarkGreyColor,
                  ),
                  // suffixIcon: IconButton(
                  //   focusColor: kDarkGreyColor,
                  //   onPressed: _toggle,
                  //   icon: _iconPwd,
                  //   color: kChocolateColor,
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  )),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text("Reset Password"),
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/kr_background.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(
                      "assets/kr_logo.png",
                    ),
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Masukkan password baru anda",
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  passwordInput(),
                  newPasswordInput(),
                  SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthResetPasswordSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kPrimaryColor,
                            content: Text(
                              state.error,
                              style: blackTextStyle,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }
                      return CustomButton(
                          title: 'RESET PASSWORD',
                          onpress: () {
                            if (newPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: kPrimaryColor,
                                  content: Text(
                                    'password tidak boleh kosong',
                                    style: blackTextStyle,
                                  ),
                                ),
                              );
                            } else if (confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: kPrimaryColor,
                                  content: Text(
                                    'confirm password tidak boleh kosong',
                                    style: blackTextStyle,
                                  ),
                                ),
                              );
                            } else {
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                context.read<AuthCubit>().resetPassword(
                                      userId: widget.userId,
                                      password: newPasswordController.text,
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kPrimaryColor,
                                    content: Text(
                                      'Konfirmasi password baru tidak sama, mohon dicek kembali.',
                                      style: blackTextStyle,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          color: kPrimaryColor);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
