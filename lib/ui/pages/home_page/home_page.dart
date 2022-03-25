import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/cubit/banner_cubit.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/cubit/category_cubit.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/cubit/product_cubit.dart';
import 'package:kampoeng_roti2/models/category_mode.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/shared/category_singleton.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_notif_page.dart';
import 'package:kampoeng_roti2/ui/pages/outlets_page/outlet_header_page.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_category_card.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_new_product_card.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_pop_up_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UserModel user = UserSingleton().user;

  @override
  void initState() {
    // setUser();
    // context.read<AuthCubit>().refreshUser(id: user.id!);
    context.read<CartCubit>().fetchCart(userId: UserSingleton().user.id!);
    // print(UserSingleton().outlet.id);
    context
        .read<CategoryCubit>()
        .fetchCategories(UserSingleton().outlet.id ?? 1);
    context
        .read<ProductCubit>()
        .fetchNewProducts(UserSingleton().outlet.id ?? 1);
    context.read<BannerCubit>().fetchBanner();
    super.initState();
  }

  // void setUser() async {
  //   int id = await MySharedPreferences.instance.getIntegerValue('userId');
  //   context.read<AuthCubit>().refreshUser(id: id);
  // }

  @override
  Widget build(BuildContext context) {
    Widget mainHeader() {
      // int outletId;
      Widget appHeader(UserAddressModel address) {
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      left: defaultMargin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Pengiriman',
                          style: blackTextStyle,
                        ),
                        Text(
                          '${address.tagAddress} - ${address.address}',
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  right: defaultMargin,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 3),
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/icon_notif.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(20),
                                // ),
                                color: kPrimaryColor,
                              ),
                              child: Text(
                                '0',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 8,
                                  fontWeight: light,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderNotifPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/icon_cart.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            Positioned(
                              top: -2,
                              right: 0,
                              child: BlocConsumer<CartCubit, CartState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is CartSuccess) {
                                    return Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.all(
                                        //   Radius.circular(20),
                                        // ),
                                        color: kPrimaryColor,
                                      ),
                                      child: Text(
                                        state.carts.length.toString(),
                                        style: whiteTextStyle.copyWith(
                                          fontSize: 8,
                                          fontWeight: light,
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      Widget pickOutlet(OutletModel outlet) {
        return Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutletHeaderPage(),
                    ));
              },
              child: Text(
                outlet.title!,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              )),
        );
      }

      return Container(
        width: double.infinity,
        height: 165,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(defaultRadius)),
        ),
        child: Column(
          children: [
            appHeader(UserSingleton().address),
            pickOutlet(UserSingleton().outlet),
          ],
        ),
      );
    }

    Widget banner() {
      int currentPage = 0;

      Widget buildDot(int index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: 5),
          height: 6,
          width: currentPage == index ? 20 : 6,
          decoration: BoxDecoration(
            color: currentPage == index ? kChocolateColor : kDarkGreyColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 20),
        child: BlocConsumer<BannerCubit, BannerState>(
          listener: (context, state) {
            if (state is BannerFailed) {
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
            if (state is BannerSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: state.banners.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                state.banners[index].imageUrl!,
                                // height: 200.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text('Image not Found !');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          state.banners.length, (index) => buildDot(index)),
                    ),
                  ),
                ],
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

    Widget icon() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  iconSize: 25,
                  icon: Image.asset(
                    "assets/ic_nearme.png",
                  ),
                  onPressed: () async {
                    // OutletModel result = await Get.to(OutletHomePage(
                    //   // currentPosition: _currentPosition,
                    //   userModel: userModel,
                    // ));
                    // setState(() {
                    //   if (result != null) {
                    //     selectedOutlet = "Outlet " + result.title;
                    //     userSingleton.outlet = result;
                    //   }
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OutletHeaderPage(),
                        ));
                  },
                ),
                Text(
                  "Near Me",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  iconSize: 30,
                  icon: Image.asset(
                    "assets/ic_promo.png",
                  ),
                  onPressed: () {
                    PromoSingleton().fromPaymentPage = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PromoPage(),
                        ));
                  },
                ),
                Text(
                  "Promo",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  iconSize: 25,
                  icon: Image.asset(
                    "assets/ic_paket.png",
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    // mainPageController.changeTabIndex(1);
                    // Get.snackbar(
                    //   "Paket belum ada",
                    //   "Oops.. paket baru sedang kami persiapkan nih, ditunggu ya..",
                    //   snackPosition: SnackPosition.BOTTOM,
                    //   backgroundColor: softOrangeColor,
                    //   margin: EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 15),
                    // );
                    context.read<PageCubit>().setPage(1);
                  },
                ),
                Text(
                  "Produk",
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget catAndNewProduct() {
      Widget category() {
        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Kategori Produk",
                      style: chocolateTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: kChocolateColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            BlocConsumer<CategoryCubit, CategoryState>(
              listener: (context, state) {
                if (state is CategoryFailed) {
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
                if (state is CategorySuccess) {
                  if (state.categories.length > 0) {
                    CategorySingleton().id = state.categories[0].id!;
                    CategorySingleton().title = state.categories[0].title!;
                    return Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              state.categories.map((CategoryModel category) {
                            return CustomCategoryCard(
                              imgUrl: category.imageUrl!,
                              title: category.title!,
                              onPress: () {
                                CategorySingleton().id = category.id!;
                                CategorySingleton().title = category.title!;
                                context.read<PageCubit>().setPage(1);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    CategorySingleton().id = 0;
                    CategorySingleton().title = '';
                  }
                  return Center(
                    child: Text(
                      'Data kosong, pilih outlet dahulu',
                      style: chocolateTextStyle,
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

            // Container(
            //   height: 150,
            // ),
          ],
        );
      }

      Widget newProduct() {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Produk Baru",
                      style: chocolateTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: kChocolateColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is ProductFailed) {
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
                if (state is ProductSuccess) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 4 / 6,
                      children: state.products.map((ProductModel newProducts) {
                        return CustomNewProductCard(
                          product: newProducts,
                          onPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPopUpDialog(
                                  product: newProducts,
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
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
          ],
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            category(),
            newProduct(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kTransparentColor,
      body: ListView(
        padding: EdgeInsets.only(top: 0, bottom: 80),
        scrollDirection: Axis.vertical,
        children: [
          mainHeader(),
          banner(),
          icon(),
          catAndNewProduct(),
        ],
      ),
    );
  }
}
