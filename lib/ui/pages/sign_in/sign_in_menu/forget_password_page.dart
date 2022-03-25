import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textFieldEmailOrUsername(String text) {
      return Theme(
        data: ThemeData(
          primaryColor: kGreyColor,
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.name,
          // controller: emailController,
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
                  RichText(
                    text: TextSpan(
                      text: 'Sudah memiliki account?',
                      style: chocolateTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Masuk disini',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/sign-in', (route) => false);
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Masukkan alamat email atau username untuk mereset password anda",
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  textFieldEmailOrUsername("Email atau Username"),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      title: 'RESET PASSWORD',
                      onpress: () {},
                      color: kPrimaryColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
