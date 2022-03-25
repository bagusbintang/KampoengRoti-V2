import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/member_menu/member_menu_sign_up.dart';

class MemberUnregisterPage extends StatelessWidget {
  final UserModel user;
  final Size size;
  const MemberUnregisterPage({
    Key? key,
    required this.user,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget memberOffer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    "assets/ic_checked_mark.png",
                  ),
                  height: 50,
                  width: 50,
                  // color: Colors.white,
                ),
                Text(
                  "POTONGAN DISKON 10%",
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    "assets/ic_checked_mark.png",
                  ),
                  height: 50,
                  width: 50,
                  // color: Colors.white,
                ),
                Text(
                  "PROMO SPECIAL KHUSUS MEMBER",
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    "assets/ic_checked_mark.png",
                  ),
                  height: 50,
                  width: 50,
                  // color: Colors.white,
                ),
                Text(
                  "INFO PRODUK TERBARU",
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget memberRegisButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        width: double.infinity,
        height: 80,
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: kChocolateColor,
          ),
          onPressed: () {
            if (user.isRequestMember != null && user.isRequestMember == 1) {
              // Get.snackbar(
              //   "Anda sudah mendaftar sebagai member, silahkan hubungi admin",
              //   "",
              //   snackPosition: SnackPosition.BOTTOM,
              //   backgroundColor: softOrangeColor,
              //   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kGreyColor,
                  content: Text(
                    'Anda sudah mendaftar sebagai member, silahkan hubungi admin',
                    style: blackTextStyle,
                  ),
                ),
              );
            } else {
              // Get.off(MemberRegister(
              //   user: user,
              // )).then((_) => Get.back());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MemberMenuSignUp(user: user)),
              );
            }
          },
          child: Text(
            "DAFTAR SEKARANG",
            style: whiteTextStyle.copyWith(fontWeight: black),
          ),
        ),
      );
    }

    return Container(
      height: size.height,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.0),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: kWhiteColor,
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/kr_logo.png",
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Anda Belum Terdaftar Sebagai Member",
                      textAlign: TextAlign.center,
                      style: whiteTextStyle.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      "Segera daftarkan diri anda sebagai member Kampoeng Roti dan dapatkan berbagai macam keuntungannya",
                      textAlign: TextAlign.center,
                      style: whiteTextStyle.copyWith(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          memberOffer(),
          Spacer(),
          memberRegisButton(),
          SizedBox(
            height: 10,
          ),
          Text(
            "*BIAYA 50.000 / SELAMANYA",
            textAlign: TextAlign.center,
            style: whiteTextStyle.copyWith(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
