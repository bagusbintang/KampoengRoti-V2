import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/cubit/order_cubit.dart';
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/component/custom_button_delivery.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/component/custom_delivery_menu.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/component/custom_picker.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/component/payment_model.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_done_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_notif_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_page_menu/item_order_detail_container.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_detail_page.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  double promoDisc = 0;
  double memberDisc = 0;
  double delivPayment = 0;
  double grandTotalDouble = 0;

  bool isDeliveryChoosen = true;
  bool isPickUpChoosen = false;
  bool isValueNotGetMinDisc = false;

  Payment? selectedPayment;
  List<Payment> paymentList = [
    Payment("COD"),
  ];

  DateTime selectDate = DateTime.now();
  var formatDate = DateFormat('d MMMM yyyy');

  void checkPromo({required double totalPrice}) {
    if (PromoSingleton().promo.id != null) {
      // promo = value;
      if (totalPrice > PromoSingleton().promo.minTrans!) {
        // print(promo.promoType);
        if (PromoSingleton().promo.promoType == 1) {
          if (PromoSingleton().promo.discount! > 100) {
            promoDisc = PromoSingleton().promo.discount!;
          } else {
            promoDisc = (PromoSingleton().promo.discount! / 100) * totalPrice;

            if (promoDisc > PromoSingleton().promo.maxDisc!) {
              promoDisc = PromoSingleton().promo.maxDisc!;
            }
            // totalDisc += promoDisc;
          }
        } else if (PromoSingleton().promo.promoType == 2) {
          if (PromoSingleton().promo.discount! > 100) {
            promoDisc = PromoSingleton().promo.discount!;
            // totalDisc += promoDisc;
          } else {
            promoDisc = (PromoSingleton().promo.discount! / 100) * delivPayment;
            if (promoDisc > PromoSingleton().promo.maxDisc!) {
              promoDisc = PromoSingleton().promo.maxDisc!;
            }
            // totalDisc += promoDisc;
          }
        }
      } else {
        isValueNotGetMinDisc = true;
      }
    } else {
      PromoSingleton().promo.title = null;
      PromoSingleton().promo.discount = null;
      PromoSingleton().promo.minTrans = null;
      PromoSingleton().promo.maxDisc = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserSingleton().isDeliveryOption = isDeliveryChoosen;

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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderNotifPage(),
                        ),
                      );
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
      return Container(
        margin: EdgeInsets.only(bottom: 0),
        child: Column(
          children: cartList
              .map((cart) => ItemOrderDetailContainer(
                    cart: cart,
                  ))
              .toList(),
        ),
      );
    }

    Widget subTotal({double? totalPrice}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

    Widget choosingDelivery({required double totalPrice}) {
      Widget chooseDelivery() {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonDelivery(
                text: 'Delivery',
                onPress: () {
                  setState(() {
                    isDeliveryChoosen = true;
                    isPickUpChoosen = false;
                    UserSingleton().isDeliveryOption = true;
                  });
                },
                backgroundColor:
                    isDeliveryChoosen ? kPrimaryColor : kWhiteColor,
                textStyle: isDeliveryChoosen
                    ? whiteTextStyle.copyWith(fontWeight: black)
                    : blackTextStyle.copyWith(fontWeight: black),
              ),
              SizedBox(
                width: 10,
              ),
              CustomButtonDelivery(
                text: 'Pick Up',
                onPress: () {
                  setState(() {
                    isDeliveryChoosen = false;
                    isPickUpChoosen = true;

                    UserSingleton().isDeliveryOption = false;
                  });
                },
                backgroundColor: isPickUpChoosen ? kPrimaryColor : kWhiteColor,
                textStyle: isPickUpChoosen
                    ? whiteTextStyle.copyWith(fontWeight: black)
                    : blackTextStyle.copyWith(fontWeight: black),
              ),
            ],
          ),
        );
      }

      Widget delivOrPickUp() {
        Widget delivHeader() {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              isDeliveryChoosen
                  ? "Delivery".toUpperCase()
                  : "Pick Up".toUpperCase(),
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: black),
            ),
          );
        }

        Widget delivBody() {
          return Visibility(
            visible: isDeliveryChoosen,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressPage(),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: kWhiteColor),
                // padding: EdgeInsets.only(left: 5),
                // padding: const EdgeInsets.only(left: 15),
                padding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Lokasi Pengiriman',
                              style: darkGreyTextStyle.copyWith(fontSize: 10),
                            ),
                          ),
                          Container(
                            child: Text(
                              " ${UserSingleton().address.tagAddress!.toUpperCase()} - ${UserSingleton().address.address!.toUpperCase()}",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: ImageIcon(
                        AssetImage("assets/icon_edit.png"),
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                      onPressed: () async {
                        // var result = await Get.to(DeliveryAddress());
                        // setState(() {
                        //   userAddress = result;
                        // });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        Widget delivFooter() {
          String options = 'Pengambilan';
          if (isDeliveryChoosen) {
            options = 'Pengiriman';
          }
          OutletModel outlet = UserSingleton().outlet;

          String distance = "( ${outlet.distance!.round()} KM )";

          return Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomDeliveryMenu(
                    title: 'Outlet ${options} ',
                    body: '${UserSingleton().outlet.title} ${distance}',
                    onPress: () {},
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomDeliveryMenu(
                    title: 'Tanggal ${options}',
                    body: DateFormat(
                      'd MMMM yyyy',
                      Localizations.localeOf(context).toString(),
                    ).format(selectDate),
                    onPress: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: selectDate,
                          maxTime: DateTime(selectDate.year, 12, 31),
                          theme: DatePickerTheme(
                            headerColor: kPrimaryColor,
                            backgroundColor: kWhiteColor,
                            itemStyle: blackTextStyle.copyWith(
                                fontSize: 18, fontWeight: bold),
                            doneStyle: blackTextStyle.copyWith(fontSize: 16),
                          ), onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        print('confirm $date');
                        setState(() {
                          selectDate = date;
                        });
                      }, currentTime: selectDate, locale: LocaleType.id);
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CustomDeliveryMenu(
                    title: 'Jam ${options}',
                    body: DateFormat.Hm().format(selectDate),
                    onPress: () {
                      DatePicker.showPicker(
                        context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                          headerColor: kPrimaryColor,
                          backgroundColor: kWhiteColor,
                          itemStyle: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
                          doneStyle: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        pickerModel: CustomPicker(
                          currentTime: selectDate,
                          locale: LocaleType.id,
                        ),
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        },
                        onConfirm: (date) {
                          print('confirm $date');
                          setState(() {
                            selectDate = date;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          // height: 200,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Column(
            children: [
              delivHeader(),
              delivBody(),
              delivFooter(),
            ],
          ),
        );
      }

      Widget grandTotalOrder() {
        Widget deliveryPrice() {
          // double deliv = 0;

          if (UserSingleton().outlet.distance!.round() > 5) {
            int range = UserSingleton().outlet.distance!.round() - 5;
            delivPayment = 2000 * range + 5000;
          } else {
            delivPayment = 5000;
          }
          // if (UserSingleton().outlet != null) {
          //   if (isDeliveryChoosen) {
          //     deliv = delivPayment;
          //   }
          // }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Biaya Pengiriman",
                  style: blackTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(delivPayment),
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, fontWeight: medium),
                ),
              ],
            ),
          );
        }

        Widget promo() {
          // String promoText = 'Tambah Promo';
          // if (PromoSingleton().promo != null) {
          //   promoText = PromoSingleton().promo.title!;
          // }
          checkPromo(totalPrice: totalPrice);
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: kWhiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Promo",
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    Visibility(
                      visible: isValueNotGetMinDisc,
                      // visible: true,
                      child: IconButton(
                        icon: Icon(
                          Icons.error_outline_outlined,
                          color: kRedColor,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: kPrimaryColor,
                              content: Text(
                                "Oops.. kamu belum memenuhi minimal pemesanan..",
                                style: blackTextStyle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    PromoSingleton().fromPaymentPage = true;
                    // PromoModel promo = PromoSingleton().promo;
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PromoPage(),
                    //   ),
                    // );
                    PromoSingleton().promo.id == null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromoPage()),
                          ).then(
                            (_) => setState(
                              () {
                                // totalDisc = 0;
                                checkPromo(totalPrice: totalPrice);
                              },
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PromoDetailPage(
                                promo: PromoSingleton().promo,
                                used: true,
                              ),
                            ),
                          ).then(
                            (value) => setState(
                              () {
                                // totalDisc = 0;
                                // promo = value;
                                if (PromoSingleton().promo == null) {
                                  promoDisc = 0;
                                  isValueNotGetMinDisc = false;
                                  // checkMemberDisc();
                                  // totalDisc += promoDisc;
                                }
                              },
                            ),
                          );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      PromoSingleton().promo.title ?? "Tambah Promo",
                      style: primaryTextStyle.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        Widget grandTotal() {
          Widget headerTotal() {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Total Pembayaran",
                style: darkGreyTextStyle.copyWith(
                    fontSize: 14, fontWeight: medium),
              ),
            );
          }

          Widget detailPrice() {
            Widget totalPriceOrder() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Harga Belanja",
                    style:
                        blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(totalPrice),
                    style:
                        blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                ],
              );
            }

            Widget discPromo() {
              return Visibility(
                visible: promoDisc > 0 ? true : false,
                // visible: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Disc Promo",
                      style:
                          redTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(promoDisc),
                      style:
                          redTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                  ],
                ),
              );
            }

            Widget discMember() {
              // double discMember = 0;
              if (UserSingleton().user.memberNo != null &&
                  UserSingleton().user.discMember != null) {
                if (UserSingleton().user.discMember! >= 100) {
                  memberDisc = UserSingleton().user.discMember!;
                } else {
                  memberDisc =
                      (UserSingleton().user.discMember! / 100) * totalPrice;
                }
              }
              return Visibility(
                visible: memberDisc > 0 ? true : false,
                // visible: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Disc Member",
                      style:
                          redTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(memberDisc),
                      style:
                          redTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                  ],
                ),
              );
            }

            Widget deliveryPayment() {
              // double deliv = 0;
              double delivPayment = 0;
              if (UserSingleton().outlet.distance!.round() > 5) {
                int range = UserSingleton().outlet.distance!.round() - 5;
                delivPayment = 2000 * range + 5000;
              } else {
                delivPayment = 5000;
              }
              // if (UserSingleton().outlet != null) {
              //   if (isDeliveryChoosen) {
              //     deliv = delivPayment;
              //   }
              // }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Biaya Pengiriman",
                    style:
                        blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(delivPayment),
                    style:
                        blackTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                ],
              );
            }

            Widget grandTotalPayment() {
              // double delivPayment = 0;
              // double grandTotal = 0;
              // double discMember = 0;
              if (UserSingleton().outlet != null) {
                if (UserSingleton().outlet.distance!.round() > 5) {
                  int range = UserSingleton().outlet.distance!.round() - 5;
                  delivPayment = 2000 * range + 5000;
                } else {
                  delivPayment = 5000;
                }
              }
              if (UserSingleton().user.memberNo != null &&
                  UserSingleton().user.discMember != null) {
                if (UserSingleton().user.discMember! >= 100) {
                  memberDisc = UserSingleton().user.discMember!;
                } else {
                  memberDisc =
                      (UserSingleton().user.discMember! / 100) * totalPrice;
                }
              }
              if (UserSingleton().outlet != null) {
                grandTotalDouble = totalPrice - memberDisc - promoDisc;
              }
              if (isDeliveryChoosen) {
                grandTotalDouble = grandTotalDouble + delivPayment;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL PAYMENT",
                    style:
                        blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(grandTotalDouble),
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                ],
              );
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                children: [
                  totalPriceOrder(),
                  discPromo(),
                  discMember(),
                  deliveryPayment(),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  grandTotalPayment(),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerTotal(),
              detailPrice(),
            ],
          );
        }

        return Container(
          // margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              deliveryPrice(),
              promo(),
              grandTotal(),
            ],
          ),
        );
      }

      return Container(
        decoration: BoxDecoration(color: kGreyColor),
        child: Column(
          children: [
            chooseDelivery(),
            delivOrPickUp(),
            grandTotalOrder(),
          ],
        ),
      );
    }

    Widget selectPayment() {
      var items = paymentList.map((item) {
        return DropdownMenuItem<Payment>(
          child: Text(item.payment, textAlign: TextAlign.center),
          value: item,
        );
      }).toList();

      return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(color: kGreyColor),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Cara Pembayaran",
                style: darkGreyTextStyle.copyWith(fontWeight: medium),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: kWhiteColor,
                  ),
                  child: DropdownButton<Payment>(
                    value: selectedPayment,
                    items: items,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    iconEnabledColor: kBlackColor,
                    hint: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Pilih Metode Pembayaran",
                          style: blackTextStyle.copyWith(fontWeight: medium)),
                    ),
                    onChanged: (item) {
                      setState(() {
                        selectedPayment = item;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }

    Widget button({required double? totalPrice}) {
      void launchWhatsApp({
        required int phone,
        required String message,
      }) async {
        String url() {
          if (Platform.isAndroid) {
            // add the [https]
            return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
          } else {
            // add the [https]
            return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
          }
        }

        if (await canLaunch(url())) {
          await launch(url());
        } else {
          throw 'Could not launch ${url()}';
        }
      }

      return BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/main', (route) => false);

            PromoSingleton().promo.id = null;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDonePage(),
                settings:
                    RouteSettings(arguments: [selectDate, isDeliveryChoosen]),
              ),
            );

            launchWhatsApp(
                phone: int.parse(UserSingleton().contactUs.whatsapp!),
                message: 'HELLO');
          } else if (state is OrderFailed) {
            print(state.error);
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
          if (state is OrderLoading) {
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
              children: <Widget>[
                CustomButton(
                  title: "SETUJU & ORDER",
                  onpress: () {
                    if (selectedPayment != null) {
                      context.read<OrderCubit>().order(
                            userId: UserSingleton().user.id!,
                            deliveryMethod: isDeliveryChoosen ? 1 : 2,
                            addressId: isDeliveryChoosen
                                ? UserSingleton().address.id!
                                : null,
                            outletId: UserSingleton().outlet.id!,
                            promoId: PromoSingleton().promo.id ?? 0,
                            shippingCosts: isDeliveryChoosen ? delivPayment : 0,
                            promoDisc: promoDisc,
                            memberDisc: memberDisc,
                            deliveryTime: selectDate.toString(),
                            paymenMethod: selectedPayment!.payment,
                            note: "",
                            total: totalPrice!,
                            grandTotal: grandTotalDouble,
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kPrimaryColor,
                          content: Text(
                            'Silahkan pilih pembayaran terlebih dahulu',
                            style: blackTextStyle,
                          ),
                        ),
                      );
                    }
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
          "Shopping Order",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderNotifPage(),
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: kWhiteColor,
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
            double total = 0;
            for (var item in state.carts) {
              total += (item.quantity! * item.prodPrice!.toInt());
            }
            return WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderNotifPage(),
                  ),
                );
                return false;
              },
              child: ListView(
                children: [
                  header(),
                  shopList(cartList: state.carts),
                  subTotal(totalPrice: total),
                  choosingDelivery(totalPrice: total),
                  selectPayment(),
                  button(totalPrice: total),
                ],
              ),
            );
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
