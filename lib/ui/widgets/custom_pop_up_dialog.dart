import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class CustomPopUpDialog extends StatelessWidget {
  final ProductModel product;
  const CustomPopUpDialog({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    int numbOfText = 1;

    Widget headers() {
      return Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Text('Image not Found !');
                },
              ),
            ),
            // Image.asset(
            //   "assets/images/banner_promo.png",
            //   fit: BoxFit.scaleDown,
            // ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/vec_love.png",
                height: 25,
                width: 25,
              ),
            ),
          ],
        ),
      );
    }

    Widget details() {
      Widget title() {
        return Container(
          child: Column(
            children: [
              Text(
                product.title!,
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                // "Rp. ${product.price}",
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(product.price),
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      Widget counter() {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              // height: 50,
              // width: 10,
              margin: EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: kGreyColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.remove,
                      size: 20,
                    ),
                    onPressed: () {
                      if (numbOfText > 1) {
                        setState(() {
                          numbOfText--;
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      numbOfText.toString().padLeft(2, "0"),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.add,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        numbOfText++;
                      });
                    },
                  )
                ],
              ),
            );
          },
        );
      }

      Widget button() {
        return BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartSuccess) {
              Navigator.pop(context);
            } else if (state is CartFailed) {
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
            if (state is CartLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: CustomButton(
                title: 'MASUKKAN KERANJANG',
                onpress: () {
                  context.read<CartCubit>().addCart(
                      userId: UserSingleton().user.id!,
                      productId: product.id!,
                      quantity: numbOfText);
                },
                color: kPrimaryColor,
              ),
            );
          },
        );
      }

      return Container(
        height: 200,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            title(),
            counter(),
            button(),
          ],
        ),
      );
    }

    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultRadius),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 180,
        child: Column(
          children: <Widget>[
            headers(),
            details(),
          ],
        ),
      ),
    );
  }
}
