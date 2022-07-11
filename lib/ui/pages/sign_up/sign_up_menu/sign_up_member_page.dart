import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/member_menu/member_menu_sign_up.dart';
import 'package:kampoeng_roti2/ui/pages/sign_in/sign_in_menu/otp_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class SignUpMemberPage extends StatefulWidget {
  final UserModel user;
  const SignUpMemberPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SignUpMemberPage> createState() => _SignUpMemberPageState();
}

class _SignUpMemberPageState extends State<SignUpMemberPage> {
  TextEditingController numberController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget header() {
      return Container(
        child: Column(
          children: [
            Text(
              "Sudah Jadi Member?",
              textAlign: TextAlign.center,
              style:
                  chocolateTextStyle.copyWith(fontSize: 40, fontWeight: bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Masukkan nomer member anda di kolom bawah.",
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }

    Widget textFieldNomerMember(String text) {
      return Theme(
        data: ThemeData(
          primaryColor: kGreyColor,
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.name,
          controller: numberController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                borderSide: BorderSide.none,
              ),
              filled: true,
              hintStyle: darkGreyTextStyle,
              hintText: text,
              // prefixIcon: icon,
              fillColor: kGreyColor),
        ),
      );
    }

    Widget submitMember() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
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
                color: kChocolateColor,
              ),
            );
          }
          return Container(
            // width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: defaultMargin),
            width: 150,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: kChocolateColor,
              ),
              onPressed: () {
                if (numberController.text.isEmpty ||
                    numberController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'Nomor member tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else {
                  context.read<AuthCubit>().registMemberNo(
                      userId: widget.user.id!, memberNo: numberController.text);
                }
              },
              child: Text(
                "SUBMIT",
                style: whiteTextStyle.copyWith(fontWeight: black),
              ),
            ),
          );
        },
      );
    }

    Widget regisMember() {
      return Container(
        child: Column(
          children: [
            Text(
              "Belum jadi Member?\nDaftarkan dirimu sekarang untuk dapat menikmati promo khusus Member Kampoeng Roti",
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              title: 'DAFTAR MEMBER',
              onpress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberMenuSignUp(
                      user: widget.user,
                      fromSignUpPage: true,
                    ),
                  ),
                );
              },
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              title: 'LEWATI',
              onpress: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
              },
              color: kPrimaryColor,
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
                header(),
                textFieldNomerMember('Nomer Member Kampoeng Roti'),
                submitMember(),
                regisMember(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
