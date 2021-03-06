import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_pop_up_dialog.dart';

class CustomProductCard extends StatelessWidget {
  final ProductModel product;
  final Function() onPress;
  const CustomProductCard({
    Key? key,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (product.outletStock! > 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopUpDialog(
                product: product,
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                        child: Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            print(exception);
                            return SizedBox(
                              height: 150,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Image not found!',
                                  style: blackTextStyle.copyWith(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    prodFav(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.title!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  // "Rp. ${product.price}",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(product.price),
                  style: chocolateTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
              ],
            ),
            prodStock(),
          ],
        ),
      ),
    );
  }

  Widget prodFav() {
    if (product.status == 1) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/vec_love.png",
          height: 25,
          width: 25,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget prodStock() {
    if (product.outletStock! > 0) {
      return SizedBox();
    } else {
      return Stack(
        children: [
          Container(
            // height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kGreyColor.withOpacity(0.6),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
          ),
          SizedBox(
            // height: 150,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Out of Stock',
                style: darkGreyTextStyle.copyWith(fontWeight: medium),
              ),
            ),
          ),
        ],
      );
    }
  }
}
