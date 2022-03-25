import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/cubit/category_cubit.dart';
import 'package:kampoeng_roti2/cubit/product_cubit.dart';
import 'package:kampoeng_roti2/models/category_mode.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/category_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_notif_page.dart';
import 'package:kampoeng_roti2/ui/pages/outlets_page/outlet_header_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_category_card.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // UserModel user = UserSingleton().user;
  CategorySingleton catSingleton = CategorySingleton();

  final TextEditingController searchController =
      TextEditingController(text: '');

  // late int outletId;
  // late int catId;
  String search = 'all';
  // String catTitle = '';

  @override
  void initState() {
    context
        .read<CategoryCubit>()
        .fetchCategories(UserSingleton().outlet.id ?? 1);
    context.read<ProductCubit>().fetchProducts(
          catId: catSingleton.id,
          outletId: UserSingleton().outlet.id ?? 1,
          search: search,
        );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
                              child: BlocBuilder<CartCubit, CartState>(
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

    Widget catAndProduct() {
      Widget categoryAndSearch() {
        Widget searchInput() {
          return Container(
            margin: EdgeInsets.only(top: 30),
            child: TextFormField(
              textAlign: TextAlign.center,
              cursorColor: kDarkGreyColor,
              controller: searchController,
              obscureText: false,
              onChanged: (value) {
                if (value != null && value != '') {
                  if (value.length >= 3) {
                    // context.read<ProductCubit>().fetchProducts(
                    //     catId: catSingleton.id,
                    //     outletId: UserSingleton().outlet.id!,
                    //     search: value);
                    setState(() {
                      search = value;
                    });
                  }
                }

                // context.read<ProductCubit>().fetchProducts(
                //       catSingleton.id,
                //       catSingleton.outletId,
                //       search,
                //     );

                // value != "" ? search = value : search = "all";
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: 'Cari Product Kampoeng Roti',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                  )),
            ),
          );
        }

        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Kategori Produk",
                      style: chocolateTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
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
                  // catSingleton.id = state.categories[0].id!;
                  // catSingleton.title = state.categories[0].title!;
                  if (state.categories.length > 0) {
                    return Container(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: state.categories
                                  .map((CategoryModel category) {
                                return CustomCategoryCard(
                                  imgUrl: category.imageUrl!,
                                  title: category.title!,
                                  onPress: () {
                                    catSingleton.id = category.id!;
                                    catSingleton.title = category.title!;
                                    context.read<ProductCubit>().fetchProducts(
                                          catId: catSingleton.id,
                                          outletId:
                                              UserSingleton().outlet.id ?? 1,
                                        );
                                    searchController.clear();
                                    setState(() {});
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          // searchInput(),
                        ],
                      ),
                    );
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

      Widget products() {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    catSingleton.title,
                    style:
                        blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
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
                  if (state.products.length == 0) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Center(
                        child: Text(
                          "Tidak menemukan hasil, mohon menggunakan kata kunci lainnya",
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: double.infinity),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: .7,
                        children: state.products.map((ProductModel product) {
                          return CustomProductCard(
                            product: product,
                            onPress: () {},
                          );
                        }).toList(),
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
          ],
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            categoryAndSearch(),
            products(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kTransparentColor,
      body: ListView(
        padding: EdgeInsets.only(bottom: 100),
        scrollDirection: Axis.vertical,
        children: [
          mainHeader(),
          // catAndNewProduct(),
          catAndProduct(),
        ],
      ),
    );
  }
}
