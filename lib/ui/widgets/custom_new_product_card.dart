import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:intl/intl.dart';

class CustomNewProductCard extends StatelessWidget {
  final ProductModel product;
  final Function() onPress;
  const CustomNewProductCard(
      {Key? key, required this.product, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
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
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Text('Image not Found !');
                      },
                    ),
                  ),
                ),
                if (product.status == 1)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/vec_love.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
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
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
