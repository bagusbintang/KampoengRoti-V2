import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/promo_model.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class PromoContainer extends StatelessWidget {
  final PromoModel promoModel;
  final Function() onPress;
  const PromoContainer({
    Key? key,
    required this.promoModel,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconImage() {
      return promoModel.imageUrl == null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0),
                ),
                color: kPrimaryColor,
              ),
              child: Center(
                child: Image(
                  image: AssetImage(
                    "assets/ic_promo.png",
                  ),
                  height: 80,
                  width: 80,
                ),
              ),
            )
          : Container(
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    promoModel.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Text('Image not Found !');
                    },
                  ),
                ),
              ),
            );
    }

    Widget promoBody() {
      String convertDateTimeDisplay(String date) {
        final DateFormat displayFormater =
            DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
        final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
        final DateTime displayDate = displayFormater.parse(date);
        final String formatted = serverFormater.format(displayDate);
        return formatted;
      }

      return Container(
        padding: EdgeInsets.only(
          left: 10,
          top: 15,
          bottom: 15,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Promo",
            //   style: TextStyle(
            //     color: softOrangeColor,
            //     fontSize: 12,
            //   ),
            // ),
            Text(
              // "BELIPERTAMA",
              promoModel.title!,
              style: chocolateTextStyle.copyWith(
                  fontSize: 14, fontWeight: semiBold),
            ),
            // Text(
            //   // "Dapatkan diskon 10% untuk pembelian pertama anda di Kampoeng Roti",
            //   promoModel.desc,
            //   style: TextStyle(
            //     // color: softOrangeColor,
            //     fontSize: 10,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: kChocolateColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Masa Berlaku",
                      style: chocolateTextStyle.copyWith(
                          fontSize: 10, fontWeight: bold),
                    ),
                    Text(
                      // "12 Jan 2019",
                      convertDateTimeDisplay(promoModel.end.toString()),
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget promoCounter() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(10),
          ),
          color: kWhiteColor,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    "assets/kr_logo.png",
                  ),
                  height: 50,
                  width: 50,
                ),
                Spacer(),
                Visibility(
                  visible: PromoSingleton().fromPaymentPage,
                  child: InkWell(
                    onTap: () {
                      PromoSingleton().promo = promoModel;
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: kPrimaryColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Text(
                        "Pakai",
                        style: whiteTextStyle.copyWith(fontWeight: semiBold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kGreyColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: iconImage(),
            ),
            Flexible(
              flex: 2,
              child: promoBody(),
            ),
            Flexible(
              flex: 1,
              child: promoCounter(),
            ),
          ],
        ),
      ),
    );
  }
}
