import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_detail_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_page_menu/item_order_container.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class OrderNotifPage extends StatefulWidget {
  const OrderNotifPage({Key? key}) : super(key: key);

  @override
  State<OrderNotifPage> createState() => _OrderNotifPageState();
}

class _OrderNotifPageState extends State<OrderNotifPage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Ringkasan Pesanan",
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  TextButton(
                    child: Text("+ Tambah"),
                    style: TextButton.styleFrom(
                      primary: kPrimaryColor,
                      textStyle: primaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
            ),
          ],
        ),
      );
    }

    Widget shopList({required List<CartModel> cartList}) {
      TextEditingController? noteController;

      void _showDialog(CartModel cart) async {
        // cartProvider = Provider.of<CartProvider>(context);
        await showDialog<String>(
          context: context,
          builder: (context) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: Row(
                children: [
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: kPrimaryColor,
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: noteController,
                        // onChanged: (value) {
                        //   widget.cart.notes = value;
                        // },
                        cursorColor: kPrimaryColor,
                        decoration:
                            InputDecoration(labelText: '', hintText: 'notes'),
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                    child: Text(
                      'Cancel',
                      style: primaryTextStyle,
                    ),
                    onPressed: () {
                      noteController!.clear();
                      Navigator.pop(context);
                    }),
                TextButton(
                    child: Text(
                      'Save',
                      style: primaryTextStyle,
                    ),
                    onPressed: () {
                      cart.notes = noteController!.text;
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      }

      return Container(
        child: Column(
          children: cartList
              .map((cart) => ItemOrderContainer(
                    cart: cart,
                    increment: () {
                      setState(() {
                        cart.quantity = cart.quantity! + 1;
                      });
                    },
                    decrement: () {
                      if (cart.quantity! > 1) {
                        setState(() {
                          cart.quantity = cart.quantity! - 1;
                        });
                      }
                    },
                    notes: () {
                      noteController =
                          TextEditingController(text: cart.notes ?? "");
                      _showDialog(cart);
                    },
                    remove: () {
                      setState(() {
                        context.read<CartCubit>().deleteCart(
                            id: cart.id!, userId: UserSingleton().user.id!);
                      });
                    },
                  ))
              .toList(),
        ),
      );
    }

    Widget subTotal({double? totalPrice}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Sub-Total",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              NumberFormat.currency(
                locale: 'id',
                symbol: 'Rp ',
                decimalDigits: 0,
              ).format(totalPrice ?? 0),
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget button({required List<CartModel> cartList}) {
      return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(),
              ),
            );
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            color: Colors.white,
            child: Column(
              children: [
                CustomButton(
                  title: "LANJUTKAN",
                  onpress: () {
                    context.read<CartCubit>().saveEditCart(carts: cartList);
                  },
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Dengan menekan tombol diatas, saya menyetujui untuk\nsyarat dan ketentuan yang berlaku",
                  style:
                      blackTextStyle.copyWith(fontSize: 10, fontWeight: medium),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
            context.read<PageCubit>().setPage(1);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/main', (route) => false);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartFailed) {
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
          if (state is CartSuccess) {
            if (state.carts.isNotEmpty) {
              double total = 0;
              for (var item in state.carts) {
                total += (item.quantity! * item.prodPrice!.toInt());
              }
              return WillPopScope(
                onWillPop: () async {
                  // context.read<CartCubit>().saveEditCart(carts: state.carts);
                  context.read<PageCubit>().setPage(1);
                  Navigator.pop(context);
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/main', (route) => false);
                  return false;
                },
                child: ListView(
                  children: [
                    header(),
                    shopList(cartList: state.carts),
                    subTotal(totalPrice: total),
                    button(cartList: state.carts),
                  ],
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Image(
                        image: AssetImage(
                          "assets/ic_empty_cart.png",
                        ),
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Keranjang belanjamu kosong",
                        style: blackTextStyle.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "BELANJA SEKARANG",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        title: "MULAI BELANJA",
                        onpress: () {
                          Navigator.pop(context);
                          context.read<PageCubit>().setPage(1);
                        },
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
