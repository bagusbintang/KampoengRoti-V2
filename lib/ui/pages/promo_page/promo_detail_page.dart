import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/promo_model.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_detail_page.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class PromoDetailPage extends StatelessWidget {
  final PromoModel promo;
  final bool used;
  const PromoDetailPage({
    Key? key,
    required this.promo,
    this.used = false,
  }) : super(key: key);

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget header() {
      if (promo.imageUrl != null) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(0),
            ),
            color: kWhiteColor,
          ),
          child: SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                promo.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      } else {
        return Container(
          height: size.height / 5,
          width: size.width,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Stack(
            children: [
              Center(
                child: Image(
                  image: AssetImage(
                    "assets/ic_promo.png",
                  ),
                  height: 80,
                  width: 80,
                ),
              ),
            ],
          ),
        );
      }
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: kGreyColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: double.maxFinite,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 30,
                          color: kChocolateColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Masa Berlaku",
                              style: chocolateTextStyle.copyWith(
                                  fontSize: 8, fontWeight: bold),
                            ),
                            Text(
                              // "12 Jan 2019",
                              convertDateTimeDisplay(promo.end.toString()),
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: semiBold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: double.maxFinite,
                color: kChocolateColor,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: double.maxFinite,
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 30,
                          color: kChocolateColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nama Promo",
                              style: chocolateTextStyle.copyWith(
                                  fontSize: 8, fontWeight: bold),
                            ),
                            Text(
                              // "PROMOGET",
                              promo.title ?? '',
                              overflow: TextOverflow.clip,
                              style: blackTextStyle.copyWith(
                                  fontSize: 8, fontWeight: semiBold),
                            ),
                          ],
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

    Widget body() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: kGreyColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 0,
            bottom: 10,
          ),
          child: Column(
            children: [
              Text(
                // "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
                promo.desc ?? '',
                style: blackTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
              //   style: TextStyle(
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ),
      );
    }

    Widget button() {
      return Visibility(
        visible: PromoSingleton().fromPaymentPage,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: CustomButton(
            title: used ? "BATALKAN" : "PAKAI",
            onpress: () {
              if (used) {
                PromoSingleton().promo.id = null;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailPage()),
                );
              } else {
                PromoSingleton().promo = promo;
                if (PromoSingleton().fromPaymentPage) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetailPage()),
                  );
                } else {
                  Navigator.pop(context);
                }
              }
            },
            color: kPrimaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promo Kampoeng Roti",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (PromoSingleton().fromPaymentPage) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PromoPage()));
            }
          },
        ),
        centerTitle: true,
        backgroundColor: kGreyColor,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (PromoSingleton().fromPaymentPage) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => PromoPage()));
          }
          return true;
        },
        child: ListView(
          children: [
            header(),
            title(),
            body(),
            button(),
          ],
        ),
      ),
    );
  }
}
