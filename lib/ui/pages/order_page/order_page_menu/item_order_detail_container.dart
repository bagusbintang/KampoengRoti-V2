import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class ItemOrderDetailContainer extends StatelessWidget {
  final CartModel cart;
  const ItemOrderDetailContainer({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  cart.prodUrlPhoto!,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cart.prodTitle!,
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: bold),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(cart.prodPrice! * cart.quantity!),
                            style: primaryTextStyle.copyWith(
                                fontSize: 12, fontWeight: medium),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(cart.prodPrice) +
                            " / biji",
                        // "Rp ${currencyFormatter.format(widget.cart.prodPrice)} / biji",
                        style: primaryTextStyle.copyWith(
                            fontSize: 10, fontWeight: semiBold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        cart.notes ?? '',
                        // "Rp ${currencyFormatter.format(widget.cart.prodPrice)} / biji",
                        style: primaryTextStyle.copyWith(
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
        ),
        const Divider(
          height: 20,
          thickness: 1,
        ),
      ],
    );
  }
}
