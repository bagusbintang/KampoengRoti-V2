import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/invoice_detail_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class AccountInvoiceDetailContainer extends StatelessWidget {
  final InvoiceDetailModel invoiceDetailModel;
  const AccountInvoiceDetailContainer({
    Key? key,
    required this.invoiceDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 20,
          thickness: 1,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                invoiceDetailModel.imageUrl!,
                height: 120,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Text('Image not Found !');
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${invoiceDetailModel.qty}x",
                      style: chocolateTextStyle.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          invoiceDetailModel.title!,
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: bold),
                        ),
                        Text(
                          // "Rp 20.000",
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(invoiceDetailModel.subTotal),
                          style: chocolateTextStyle.copyWith(
                              fontSize: 12, fontWeight: medium),
                        ),
                      ],
                    ),
                    Text(
                      NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(invoiceDetailModel.price) +
                          " / biji",
                      style: chocolateTextStyle.copyWith(
                          fontSize: 10, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
