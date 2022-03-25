import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/invoice_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_contact_us_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_invoice_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_invoice_detail_container.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class AccountInvoiceDetailPage extends StatelessWidget {
  final InvoiceModel invoiceModel;
  const AccountInvoiceDetailPage({
    Key? key,
    required this.invoiceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('d MMMM yyyy');
    var formatTime = DateFormat.Hm();

    bool visibleButton;

    double promoDisc = 0;
    double memberDisc = 0;
    if (invoiceModel.iHeaderPromoDisc! >= 100) {
      promoDisc = invoiceModel.iHeaderPromoDisc!;
    } else {
      promoDisc =
          (invoiceModel.iHeaderPromoDisc! / 100) * invoiceModel.iHeaderTotal!;
    }

    if (invoiceModel.iHeaderMemberDisc! >= 100) {
      memberDisc = invoiceModel.iHeaderMemberDisc!;
    } else {
      memberDisc =
          (invoiceModel.iHeaderMemberDisc! / 100) * invoiceModel.iHeaderTotal!;
    }
    if (invoiceModel.iStatus == '1') {
      visibleButton = true;
    } else {
      visibleButton = false;
    }

    Widget header() {
      return Container(
        padding: EdgeInsets.all(15.0),
        color: kPrimaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Status Pesanan",
              style: whiteTextStyle.copyWith(fontSize: 10),
            ),
            Text(
              invoiceModel.iHeaderStatus!,
              style:
                  whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget orderDate() {
      return Container(
        // color: Colors.white,
        decoration: BoxDecoration(color: kWhiteColor),
        // margin: EdgeInsets.only(bottom: 4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanggal Pemesanan",
                style:
                    blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
              ),
              Text(
                // "12 Desember 2021" + " | " + "05 AM - 10 AM",
                '${formatDate.format(invoiceModel.iHeaderDelivTime!)} ' +
                    '${formatTime.format(invoiceModel.iHeaderDelivTime!)}',
                style: darkGreyTextStyle.copyWith(
                    fontSize: 12, fontWeight: semiBold),
              ),
            ],
          ),
        ),
      );
    }

    Widget statusAddress() {
      return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // color: Colors.white,
        decoration: BoxDecoration(color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Alamat Pengiriman",
                  style: darkGreyTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      color: kYellowColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )),
                  child: Text(
                    invoiceModel.iHeaderDelivMethod!.toUpperCase(),
                    style:
                        whiteTextStyle.copyWith(fontSize: 8, fontWeight: bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              // "Bima Aprianto Siono (Rumah Prambanan)",
              invoiceModel.iHeaderName ?? "",
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            Text(
              // "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213",
              invoiceModel.iHeaderAddress ?? "",
              style: blackTextStyle.copyWith(fontSize: 12),
              overflow: TextOverflow.clip,
            ),
            Text(
              // "No. Telpon : 081805512618",
              "No. Telpon : ${invoiceModel.iHeaderPhone}",
              style: chocolateTextStyle.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    Widget information() {
      double totalPrice = invoiceModel.iHeaderTotal! +
          invoiceModel.iHeaderOngkir! -
          promoDisc -
          memberDisc;
      return Container(
        margin: EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        // color: Colors.white,
        decoration: BoxDecoration(color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Pembayaran",
              style: darkGreyTextStyle.copyWith(
                  fontSize: 12, fontWeight: semiBold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Belanja",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  // "Rp 125.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(invoiceModel.iHeaderTotal),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Visibility(
              visible: promoDisc > 0 ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Disc Promo",
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                  Text(
                    // "Rp. 25.000",
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(promoDisc),
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: memberDisc > 0 ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Disc Member",
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                  Text(
                    // "Rp. 25.000",
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(memberDisc),
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Biaya Pengiriman",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  // "Rp 25.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(invoiceModel.iHeaderOngkir),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL PAYMENT",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                Text(
                  // "Rp 150.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(totalPrice),
                  style: chocolateTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    Widget detailOrder() {
      return Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ringkasan Pesanan",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
            ),
            Container(
              // child: Column(
              //   children: List.generate(
              //     3,
              //     (index) => HistoryItemOrder(),
              //   ),
              // ),
              child: Column(
                children: invoiceModel.invDetail!
                    .map((detail) => AccountInvoiceDetailContainer(
                          invoiceDetailModel: detail,
                        ))
                    .toList(),
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
          ],
        ),
      );
    }

    Widget summaryOrder() {
      double totalPrice = invoiceModel.iHeaderTotal! +
          invoiceModel.iHeaderOngkir! -
          promoDisc -
          memberDisc;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // color: Colors.white,
        decoration: BoxDecoration(color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ringkasan Pembayaran",
                  style: darkGreyTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga Belanja",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  // "Rp. 25.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(invoiceModel.iHeaderTotal),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            Visibility(
              visible: promoDisc > 0 ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Disc Promo",
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                  Text(
                    // "Rp. 25.000",
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(promoDisc),
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: memberDisc > 0 ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Disc Member",
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                  Text(
                    // "Rp. 25.000",
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(memberDisc),
                    style: redTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Biaya Pengiriman",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  // "Rp 25.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(invoiceModel.iHeaderOngkir),
                  style: blackTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  // "Rp 150.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(totalPrice),
                  style: chocolateTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Visibility(
        visible: visibleButton,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              CustomButton(
                  title: 'KONFIRMASI PEMBAYARAN',
                  onpress: () {},
                  color: kPrimaryColor)
            ],
          ),
        ),
      );
    }

    Widget contactAdmin() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            Text(
              "Untuk Bantuan & Pertanyaan:",
              style:
                  darkGreyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: kYellowColor,
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountContactUsPage(),
                  ),
                );
              },
              child: Text(
                "Hubungi Kami",
                style: whiteTextStyle.copyWith(fontWeight: semiBold),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        title: Text(
          "Detail Pesanan",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AccountInvoicePage()),
              );
            }),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AccountInvoicePage()),
          );
          return false;
        },
        child: ListView(
          children: [
            header(),
            orderDate(),
            statusAddress(),
            information(),
            detailOrder(),
            summaryOrder(),
            button(),
            contactAdmin(),
          ],
        ),
      ),
    );
  }
}
