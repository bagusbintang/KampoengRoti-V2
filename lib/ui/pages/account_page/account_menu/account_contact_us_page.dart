import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/contact_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_mini_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountContactUsPage extends StatefulWidget {
  const AccountContactUsPage({Key? key}) : super(key: key);

  @override
  State<AccountContactUsPage> createState() => _AccountContactUsPageState();
}

class _AccountContactUsPageState extends State<AccountContactUsPage> {
  @override
  void initState() {
    context.read<ContactCubit>().getContact();
  }

  @override
  Widget build(BuildContext context) {
    void launchWhatsApp({
      required int phone,
      required String message,
    }) async {
      String url() {
        // if (Platform.isAndroid) {
        //   // add the [https]
        //   // return 'whatsapp://send?phone=$phone&${Uri.parse(message)}';
        //   return "https://wa.me/send?$phone/?text=${Uri.parse(message)}"; // new line
        // } else {
        //   // add the [https]
        //   return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
        // }
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
              BlocConsumer<ContactCubit, ContactState>(
                listener: (context, state) {
                  if (state is ContactFailed) {
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
                  if (state is ContactSuccess) {
                    UserSingleton().contactUs = state.contact;
                    return Column(
                      children: [
                        AccountMiniButton(
                          text: "Whatsapp",
                          onPress: () {
                            launchWhatsApp(
                                phone: int.parse(state.contact.whatsapp!),
                                message: 'Hello.');
                          },
                        ),
                        // AccountMiniButton(
                        //   text: "Whatsapp",
                        //   onPress: () {
                        //     launchWhatsApp(
                        //         phone: 6282234334552, message: 'Hello.');
                        //   },
                        // ),
                        AccountMiniButton(
                          text: "Telp",
                          onPress: () {
                            launch("tel:${state.contact.phone}");
                          },
                        ),
                        AccountMiniButton(
                          text: "Email",
                          onPress: () {
                            final Uri _emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: state.contact.email,
                                queryParameters: {
                                  'subject': 'Kendala Aplikasi'
                                });

                            launch(_emailLaunchUri.toString());
                          },
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: kChocolateColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
