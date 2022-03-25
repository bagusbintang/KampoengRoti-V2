import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_mini_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountShareAppPage extends StatelessWidget {
  const AccountShareAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void launchWhatsApp({
      required int phone,
      required String message,
    }) async {
      String url() {
        if (Platform.isAndroid) {
          // add the [https]
          return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
        } else {
          // add the [https]
          return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
        }
      }

      if (await canLaunch(url())) {
        await launch(url());
      } else {
        throw 'Could not launch ${url()}';
      }
    }

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/kr_background.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   height: size.height / 10,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       color: softOrangeColor,
              //       borderRadius: BorderRadius.vertical(
              //           bottom: Radius.elliptical(size.width, 80))),
              // ),
              Container(
                height: size.height / 3,
                width: size.width,
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 4,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(size.width, 150))),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kPrimaryColor,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Image(
                            image: AssetImage(
                              "assets/kr_logo.png",
                            ),
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "APLIKASI",
                        style: chocolateTextStyle.copyWith(
                            fontSize: 40, fontWeight: bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Scan QR Code dibawah ini untuk membagikan aplikasi Kampoeng Roti",
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              QrImage(
                version: 5,
                backgroundColor: kGreyColor,
                foregroundColor: kBlackColor,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
                padding: EdgeInsets.all(20),
                size: 250,
                data: "http://kampoengroti.com/home",
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Bagi Aplikasi Lewat Lainnya",
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              SizedBox(
                height: 15,
              ),
              AccountMiniButton(
                text: "Whatsapp",
                onPress: () {
                  launchWhatsApp(phone: 628983898855, message: 'Hello');
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
