import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/shared/shared_pref.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_menu/add_address_page.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_menu/edit_address_page.dart';
import 'package:kampoeng_roti2/ui/pages/sign_in/sign_in_menu/forget_password_page.dart';
import 'package:kampoeng_roti2/ui/pages/sign_up/sign_up_menu/sign_up_otp_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  UserSingleton userSingleton = UserSingleton();

  final TextEditingController userController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool _obscureText = true;

  Icon _iconPwd = Icon(Icons.remove_red_eye_outlined);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        _iconPwd = Icon(Icons.remove_red_eye);
      } else {
        _iconPwd = Icon(Icons.remove_red_eye_outlined);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconAndTitle() {
      return Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/kr_logo.png'),
              ),
            ),
          ),
          Text(
            'Selamat Datang di\nKampoeng Roti',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 32,
              fontWeight: extraBold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      );
    }

    Widget userInput() {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          cursorColor: kDarkGreyColor,
          controller: userController,
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(25),
              filled: true,
              fillColor: kGreyColor,
              hintText: 'email/no telp',
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.0),
                child: ImageIcon(
                  AssetImage('assets/user.png'),
                  color: kDarkGreyColor,
                ),
              ),
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
      );
    }

    Widget passwordInput() {
      // bool obscurePwd = true;

      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          cursorColor: kDarkGreyColor,
          controller: passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(25),
              filled: true,
              fillColor: kGreyColor,
              hintText: 'password',
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.0),
                child: ImageIcon(
                  AssetImage('assets/padlock.png'),
                  color: kDarkGreyColor,
                ),
              ),
              suffixIcon: IconButton(
                focusColor: kDarkGreyColor,
                onPressed: _toggle,
                icon: _iconPwd,
                color: kChocolateColor,
              ),
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
      );
    }

    Widget rememberAndForgetPassword() {
      bool _checkBoxValue = true;
      void _checkBoxOnChange() {}

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 25,
                    height: 25,
                    child: Checkbox(
                      // contentPadding: EdgeInsets.all(0),
                      // title: Text(
                      //   "Ingat Saya",
                      //   style: TextStyle(
                      //     color: Colors.grey[600],
                      //     fontSize: 12,
                      //   ),
                      // ),
                      value: _checkBoxValue,
                      activeColor: Colors.grey[600],
                      onChanged: null,
                      // controlAffinity: ListTileControlAffinity
                      //     .leading, //  <-- leading Checkbox
                    ),
                  ),
                  Text(
                    "Ingat Saya",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  child: Text(
                    "Lupa Password?",
                    textAlign: TextAlign.center,
                    style: chocolateTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget submitButon() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.user.verified == 1) {
              MySharedPreferences.instance.setLoginValue("login", true);
              MySharedPreferences.instance
                  .setIntegerValue("userId", state.user.id);
              UserSingleton().user = state.user;
              UserSingleton().address = state.user.defaulAdress!;
              UserSingleton().outlet = state.user.defaulAdress!.outletModel!;

              if (UserSingleton().address.tagAddress == 'Default') {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditAddressPage(),
                //     settings: RouteSettings(arguments: UserSingleton().address),
                //   ),
                // );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddressPage(),
                      settings: RouteSettings(arguments: state.user.id),
                    ));
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
              }
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpOtpPage(
                    user: state.user,
                    email: state.user.email!,
                    isGuestCheckOut: false,
                  ),
                ),
              );
            }
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
            title: 'MASUK',
            color: kPrimaryColor,
            onpress: () {
              context.read<AuthCubit>().signIn(
                    email: userController.text,
                    password: passwordController.text,
                  );
            },
          );
        },
      );
    }

    Widget signUpButton() {
      return Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Belum Punya Akun Kampoeng Roti?",
              style: TextStyle(color: Colors.grey[600]),
            ),
            TextButton(
              child: Text(
                "Daftar Akun",
                style: chocolateTextStyle.copyWith(
                  fontWeight: semiBold,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/sign-up');
              },
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
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: Text(
            'Halaman Login',
          ),
          leading: BackButton(
            color: kWhiteColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // margin: EdgeInsets.all(defaultMargin),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/kr_background.png',
                ),
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              iconAndTitle(),
              userInput(),
              passwordInput(),
              rememberAndForgetPassword(),
              submitButon(),
              signUpButton(),
            ],
          ),
        ],
      ),
    );
  }
}
