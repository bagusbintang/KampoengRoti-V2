import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/shared/shared_pref.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';
import '../../shared/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
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
              fontSize: 30,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Kampoeng Roti menyediakan berbagai macam jenis roti dengan varian rasa dan harga yang sangat terjangkau.',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
        ],
      );
    }

    Widget button() {
      bool isLoggedIn = false;
      return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                UserSingleton().user = state.user;
                UserSingleton().address = state.user.defaulAdress!;
                UserSingleton().outlet = state.user.defaulAdress!.outletModel!;
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
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
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                );
              }
              return CustomButton(
                title: 'MASUK',
                color: kPrimaryColor,
                margin: EdgeInsets.only(
                  bottom: 50,
                ),
                onpress: () async {
                  isLoggedIn =
                      await MySharedPreferences.instance.getLoginValue("login");
                  int id = await MySharedPreferences.instance
                      .getIntegerValue('userId');

                  // bool isLoggedIn = UserSingleton().isLoggin;

                  if (isLoggedIn) {
                    context.read<AuthCubit>().refreshUser(id: id);
                  } else {
                    Navigator.pushNamed(context, '/sign-in');
                  }
                },
              );
            },
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/kr_background.png'),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: kTransparentColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                  ),
                  header(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/9,
                  ),
                  button(),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Spacer(),
                  //     header(),
                  //     button(),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
