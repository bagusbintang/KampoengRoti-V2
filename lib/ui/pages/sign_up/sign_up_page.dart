import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/sign_up/sign_up_menu/sign_up_member_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  LatLng? currentPostion;

  bool _obscureText = true;

  bool _checkBoxValue = true;

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
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (mounted) {
      _getUserLocation();
    }
    super.initState();
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget iconHeader() {
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
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget inputSection() {
      Widget userInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: TextFormField(
            cursorColor: kDarkGreyColor,
            controller: usernameController,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(25),
                filled: true,
                fillColor: kGreyColor,
                hintText: 'username',
                prefixIcon: Icon(
                  Icons.person,
                  color: kDarkGreyColor,
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

      Widget emailInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: TextFormField(
            cursorColor: kDarkGreyColor,
            controller: emailController,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(25),
                filled: true,
                fillColor: kGreyColor,
                hintText: 'email',
                prefixIcon: Icon(
                  Icons.person,
                  color: kDarkGreyColor,
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

      Widget phoneInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: TextFormField(
            cursorColor: kDarkGreyColor,
            controller: phoneController,
            obscureText: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(25),
                filled: true,
                fillColor: kGreyColor,
                hintText: 'phone',
                prefixIcon: Icon(
                  Icons.person,
                  color: kDarkGreyColor,
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
                prefixIcon: Icon(
                  Icons.lock,
                  color: kDarkGreyColor,
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

      return Column(
        children: [
          userInput(),
          emailInput(),
          phoneInput(),
          passwordInput(),
        ],
      );
    }

    Widget submitButon() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpMemberPage(user: state.user),
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
            title: 'DAFTAR AKUN',
            color: kPrimaryColor,
            onpress: () {
              if (usernameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      'username tidak boleh kosong',
                      style: blackTextStyle,
                    ),
                  ),
                );
              } else if (emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      'email tidak boleh kosong',
                      style: blackTextStyle,
                    ),
                  ),
                );
              } else if (phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      'phone tidak boleh kosong',
                      style: blackTextStyle,
                    ),
                  ),
                );
              } else if (passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      'password tidak boleh kosong',
                      style: blackTextStyle,
                    ),
                  ),
                );
              } else if (currentPostion == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      'posisi tidak di ketahui',
                      style: blackTextStyle,
                    ),
                  ),
                );
              } else {
                context.read<AuthCubit>().signUp(
                      username: usernameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      password: passwordController.text,
                      lat: currentPostion!.latitude,
                      long: currentPostion!.longitude,
                    );
              }
            },
          );
        },
      );
    }

    Widget termCondition() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _checkBoxValue,
              activeColor: kChocolateColor,
              onChanged: null,
              // (bool newValue) {
              //   setState(() {
              //     _checkBoxValue = newValue;
              //   });
              // },
            ),
            RichText(
              text: TextSpan(
                text: 'Saya Setuju Dengan',
                style: chocolateTextStyle.copyWith(fontWeight: semiBold),
                children: [
                  TextSpan(
                    text: ' Syarat &\nKetentuan',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(text: ' Kampoeng Roti'),
                ],
              ),
            ),
            // Text(
            //   'Saya Setuju Dengan Terms dan\nCondition Kampoeng Roti',
            //   style: TextStyle(
            //     color: choclateColor,
            //     fontWeight: FontWeight.w600,
            //     fontSize: 14,
            //   ),
            //   textAlign: TextAlign.start,
            // ),
          ],
        ),
      );
    }

    Widget signInButton() {
      return Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Sudah Punya Akun Kampoeng Roti?",
              style: darkGreyTextStyle,
            ),
            TextButton(
              child: Text(
                "Masuk Akun",
                style: chocolateTextStyle.copyWith(
                  fontWeight: semiBold,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
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
          title: Text("Buat Akun"),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: BackButton(
            color: kWhiteColor,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            },
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
          return false;
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage("assets/kr_background.png"),
                    fit: BoxFit.cover),
              ),
            ),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
                iconHeader(),
                inputSection(),
                submitButon(),
                termCondition(),
                signInButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
