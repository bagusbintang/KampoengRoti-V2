import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_mini_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountContactUsPage extends StatelessWidget {
  const AccountContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            image: DecorationImage(
                image: AssetImage("assets/kr_background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Hubungi Kami",
                        style: chocolateTextStyle.copyWith(
                            fontSize: 40, fontWeight: bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hubungi kami untuk mengetahui informasi lebih lanjut mengenai produk atau layanan kami",
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
              AccountMiniButton(
                text: "Whatsapp",
                onPress: () {
                  launchWhatsApp(phone: 628983898855, message: 'Hello');
                },
              ),
              AccountMiniButton(
                text: "Telp",
                onPress: () {
                  launch("tel:082234334552");
                },
              ),
              AccountMiniButton(
                text: "Email",
                onPress: () {
                  final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'cs@kampoengroti.com',
                      queryParameters: {'subject': 'Kendala Aplikasi'});

                  launch(_emailLaunchUri.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
