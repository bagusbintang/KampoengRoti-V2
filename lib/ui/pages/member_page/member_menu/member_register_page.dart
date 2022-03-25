import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MemberRegisterPage extends StatelessWidget {
  final UserModel user;
  final Size size;
  const MemberRegisterPage({
    Key? key,
    required this.user,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget expiredAndNumberMember() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        height: 100,
        color: kTransparentColor,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "MASA BERLAKU",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: semiBold),
                        ),
                        Text(
                          "Seumur Hidup",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: regular),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: double.maxFinite,
                color: Colors.black,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "NOMOR MEMBER",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: semiBold),
                        ),
                        Text(
                          // "000378433",
                          user.memberNo ?? "",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: regular),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                children: <Widget>[
                  // Image(
                  //   image: AssetImage(
                  //     "assets/images/kr_logo.png",
                  //   ),
                  //   height: 150,
                  //   width: 150,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Selamat Datang",
                    style:
                        blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                  ),
                  Text(
                    // "Bima Aprianto Siono",
                    user.name ?? "",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  QrImage(
                    version: 5,
                    backgroundColor: kWhiteColor,
                    foregroundColor: kBlackColor,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    padding: EdgeInsets.all(20),
                    size: 200,
                    data: "https://www.qrcode.com/en/about/version.html",
                  ),
                  expiredAndNumberMember(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100
                          // topLeft: Radius.circular(5),
                          // topRight: Radius.circular(5),
                          // bottomLeft: Radius.circular(5),
                          // bottomRight: Radius.circular(5),
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
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
