import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_page.dart';
import 'package:kampoeng_roti2/ui/pages/home_page/home_page.dart';
import 'package:kampoeng_roti2/ui/pages/order_page/order_page.dart';
import 'package:kampoeng_roti2/ui/pages/outlets_page/outlets_page.dart';
import 'package:kampoeng_roti2/ui/pages/product_page/product_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_bottom_navigation_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  // void setUser() async {
  //   int id = await MySharedPreferences.instance.getIntegerValue('userId');
  //   context.read<AuthCubit>().refreshUser(id: id);
  // }

  @override
  Widget build(BuildContext context) {
    Widget buildContain(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();

        case 1:
          return ProductPage();

        case 2:
          return OrderPage();

        case 3:
          return OutletsPage();
        case 4:
          return AccountPage();

        default:
          return HomePage();
      }
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: kWhiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationItem(
                index: 0,
                title: 'Home',
                imageUrl: 'assets/ic_home.png',
              ),
              CustomBottomNavigationItem(
                index: 1,
                title: 'Product',
                imageUrl: 'assets/icon_product.png',
              ),
              CustomBottomNavigationItem(
                index: 2,
                title: 'Order',
                imageUrl: 'assets/icon_cart.png',
              ),
              CustomBottomNavigationItem(
                index: 3,
                title: 'Outlets',
                imageUrl: 'assets/icon_outlets.png',
              ),
              CustomBottomNavigationItem(
                index: 4,
                title: 'Akun',
                imageUrl: 'assets/ic_acc.png',
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currengIndex) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                // margin: EdgeInsets.all(defaultMargin),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/kr_background.png',
                    ),
                  ),
                ),
              ),
              buildContain(currengIndex),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
