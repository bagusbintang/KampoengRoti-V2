import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/invoice_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_invoice_detail_page.dart';

class AccountInvoiceContainer extends StatelessWidget {
  final InvoiceModel invoice;
  const AccountInvoiceContainer({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _invoiceStatus = invoice.iHeaderDelivMethod!;
    String _orderStatus = invoice.iHeaderStatus!;
    double promoDisc;
    double memberDisc;
    Color? _colorStatus = kYellowColor;

    var formatDate = DateFormat('d MMMM yyyy');
    var formatTime = DateFormat.Hm();

    if (invoice.iHeaderPromoDisc! >= 100) {
      promoDisc = invoice.iHeaderPromoDisc!;
    } else {
      promoDisc = (invoice.iHeaderPromoDisc! / 100) * invoice.iHeaderTotal!;
    }

    if (invoice.iHeaderMemberDisc! >= 100) {
      memberDisc = invoice.iHeaderMemberDisc!;
    } else {
      memberDisc = (invoice.iHeaderMemberDisc! / 100) * invoice.iHeaderTotal!;
    }

    if (invoice.iStatus == '2' && invoice.iDelivery == '1') {
      _colorStatus = kOrangeColor;
    }

    Widget invoiceStatus() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kOrangeColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Center(
          child: Text(
            _invoiceStatus,
            style: whiteTextStyle.copyWith(fontWeight: bold),
          ),
        ),
      );
    }

    Widget orderStatus() {
      Widget status() {
        return Container(
          // decoration: BoxDecoration(color: kRedColor),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: kDarkGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              _orderStatus,
              style: whiteTextStyle.copyWith(fontSize: 8, fontWeight: bold),
            ),
          ),
        );
      }

      Widget orderHeader() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${formatDate.format(invoice.iHeaderDelivTime!)} ' +
                  '${formatTime.format(invoice.iHeaderDelivTime!)}',
              style: darkGreyTextStyle.copyWith(
                  fontSize: 10, fontWeight: semiBold),
            ),
            Text(
              invoice.iHeaderNo ?? "",
              style: blackTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        );
      }

      return Container(
        // decoration: BoxDecoration(color: kGreyColor),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            orderHeader(),
            status(),
          ],
        ),
      );
    }

    Widget body() {
      double totalPrice = invoice.iHeaderTotal! +
          invoice.iHeaderOngkir! -
          promoDisc -
          memberDisc;
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Spacer(),
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  invoice.invDetail![0].imageUrl!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Text('Image not Found !');
                  },
                ),
              ),
            ),
            // Spacer(),
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Text(
                      invoice.invDetail![0].title!,
                      style: blackTextStyle,
                    ),
                    Text(
                      "(+${invoice.invDetail!.length - 1} Produk lainnya)",
                      style: darkGreyTextStyle.copyWith(
                          fontSize: 8, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Total Pembayaran",
                      style: darkGreyTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(totalPrice),
                      style: chocolateTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                  ],
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AccountInvoiceDetailPage(invoiceModel: invoice)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            invoiceStatus(),
            orderStatus(),
            const Divider(
              thickness: 1,
            ),
            body(),
          ],
        ),
      ),
    );
  }
}
