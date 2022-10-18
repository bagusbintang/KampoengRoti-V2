import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_contact_us_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDonePage extends StatefulWidget {
  const OrderDonePage({Key? key}) : super(key: key);

  @override
  State<OrderDonePage> createState() => _OrderDonePageState();
}

class _OrderDonePageState extends State<OrderDonePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final routeArgs1 = ModalRoute.of(context)!.settings.arguments as String;

      dynamic data = ModalRoute.of(context)!.settings.arguments;
      dynamic grandtotal = data[2];
      if (double.parse(grandtotal.toString()) > 250000) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: kPrimaryColor,
        //     content: Text(
        //       "Mohon maaf untuk pemesanan sudah melebihi batas maksimal, customer service kami akan segera menghubungi anda",
        //       textAlign: TextAlign.justify,
        //       style: blackTextStyle,
        //     ),
        //   ),
        // );
        _showDialog();
      }
    });
  }

  void _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: [
              Expanded(
                child: Text(
                  "Mohon maaf untuk pemesanan sudah melebihi batas maksimal, customer service kami akan segera menghubungi anda",
                  textAlign: TextAlign.left,
                  style: chocolateTextStyle.copyWith(fontWeight: semiBold),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                child: Text(
                  'Mengerti',
                  style: primaryTextStyle,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    bool isDeliv = data[1];
    DateTime date = data[0];
    dynamic grandtotal = data[2];
    var formatDate = DateFormat('d MMMM yyyy');

    Widget header() {
      return Container(
        height: size.height / 3,
        width: size.width,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(size.width, 150))),
        child: Column(
          children: [
            Spacer(),
            Image(
              image: AssetImage(
                "assets/order.png",
              ),
              height: 100,
              width: 100,
              color: kWhiteColor,
            ),
            Text(
              "Order Berhasil",
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Order anda telah tercatat, hubungi kami\napabila membutuhkan bantuan",
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            Spacer(),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage(
                "assets/appointment.png",
              ),
              height: 80,
              width: 80,
              color: kChocolateColor,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  color: kChocolateColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Center(
                child: Text(
                  isDeliv
                      ? "Delivery Order".toUpperCase()
                      : "Pick Up".toUpperCase(),
                  style:
                      whiteTextStyle.copyWith(fontSize: 10, fontWeight: bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              isDeliv
                  ? "Terima Kasih, pesanan Anda akan diantar :"
                  : "Terima Kasih, pesanan Anda siap diambil :",
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              // "SELASA. 12 MEI 2021 Pk. 10.00",
              "${formatDate.format(date)} Pk. ${DateFormat.Hm().format(date)}",
              style:
                  chocolateTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Jika ada perubahan, kami akan memberitahu\nAnda secepatnya, dikolom notifikasi",
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "*syarat dan ketentuan berlaku",
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Order diatas 200rb wajib transfer DP 50% \n' +
                    'Rek BCA a/n Hendra Goenawan ',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
                children: [
                  TextSpan(
                    text: '319 514 1988',
                    style: chocolateTextStyle.copyWith(
                      fontWeight: bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Clipboard.setData(
                            const ClipboardData(text: '319 514 1988'));
                        // key.currentState
                        //     .showSnackBar(new SnackBar(
                        //   content:
                        //       new Text("Copied to Clipboard"),
                        // ));
                      },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              title: 'Kembali ke Halaman Utama',
              onpress: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
                context.read<PageCubit>().setPage(0);
              },
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              title: 'Hubungi Admin',
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountContactUsPage()),
                );
              },
              color: kPrimaryColor,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
          return false;
        },
        child: Stack(
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
              children: [
                header(),
                body(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToolTip extends StatelessWidget {
  String text;

  CustomToolTip({required this.text});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(
          preferBelow: false, message: "Copy", child: new Text(text)),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: text));
      },
    );
  }
}
