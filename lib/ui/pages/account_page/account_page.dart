import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/shared_pref.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_contact_us_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_edit_profil_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_faq_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_invoice_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/account_menu/account_share_app_page.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_menu_container.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/member_page.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserModel user = UserSingleton().user;
  @override
  void initState() {
    context.read<AuthCubit>().refreshUser(id: user.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      Size size = MediaQuery.of(context).size;
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
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
          if (state is AuthSuccess) {
            UserSingleton().user = state.user;
            return Container(
              // padding: EdgeInsets.only(top: 25),
              height: size.height / 5,
              width: size.width,
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: null,
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                      size: 50,
                    ),
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.user.name ?? '',
                            // userSingleton.user.name,
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.user.email ?? '',
                            // userSingleton.user.email,
                            style: whiteTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.user.phone ?? '',
                            // userSingleton.user.phone != null
                            //     ? userSingleton.user.phone.toString()
                            //     : " - ",
                            style: whiteTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountEditProfilPage(
                                    user: user,
                                  ),
                                ));
                          },
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Ubah Profil",
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            height: size.height / 5,
            width: size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: kWhiteColor,
              ),
            ),
          );
        },
      );
    }

    Widget accountMenu() {
      return Container(
        child: Column(
          children: [
            AccountMenuContainer(
              titleName: 'Riwayat Transaksi',
              icon: Icon(
                Icons.history_edu,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountInvoicePage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'Alamat',
              icon: Icon(
                Icons.location_on,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'Promo',
              icon: Icon(
                Icons.next_plan,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                PromoSingleton().fromPaymentPage = false;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PromoPage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'Bagi Aplikasi',
              icon: Icon(
                Icons.share,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountShareAppPage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'Member Kampoeng Roti',
              icon: Icon(
                Icons.credit_card,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                // if (UserSingleton().user.isRequestMember == 1) {
                //   // Get.to(ConfirmPayment());
                // } else {
                //   // Get.to(MemberPage(
                //   //   user: userSingleton.user,
                //   // ));
                // }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberPage(
                        user: UserSingleton().user,
                      ),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'FAQ',
              icon: Icon(
                Icons.question_answer,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountFaqPage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: 'Hubungi Kami',
              icon: Icon(
                Icons.call,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountContactUsPage(),
                    ));
              },
            ),
            AccountMenuContainer(
              titleName: "Keluar",
              icon: Icon(
                Icons.logout,
                size: 30,
                color: kPrimaryColor,
              ),
              onPress: () async {
                // MySharedPreferences.instance.removeAll();
                // UserSingleton().user = null;
                MySharedPreferences.instance.removeAll();
                context.read<PageCubit>().setPage(0);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          header(),
          accountMenu(),
        ],
      ),
    );
  }
}
