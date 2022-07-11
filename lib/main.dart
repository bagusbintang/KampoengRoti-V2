import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/cubit/banner_cubit.dart';
import 'package:kampoeng_roti2/cubit/cart_cubit.dart';
import 'package:kampoeng_roti2/cubit/category_cubit.dart';
import 'package:kampoeng_roti2/cubit/contact_cubit.dart';
import 'package:kampoeng_roti2/cubit/faq_cubit.dart';
import 'package:kampoeng_roti2/cubit/invoice_cubit.dart';
import 'package:kampoeng_roti2/cubit/order_cubit.dart';
import 'package:kampoeng_roti2/cubit/outlet_cubit.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/cubit/product_cubit.dart';
import 'package:kampoeng_roti2/cubit/promo_cubit.dart';
import 'package:kampoeng_roti2/cubit/user_address_cubit.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/sign_up/sign_up_page.dart';

import 'ui/pages/main_page.dart';
import 'ui/pages/sign_in/sign_in_pages.dart';
import 'ui/pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => BannerCubit(),
        ),
        BlocProvider(
          create: (context) => UserAddressCubit(),
        ),
        BlocProvider(
          create: (context) => OutletCubit(),
        ),
        BlocProvider(
          create: (context) => FaqCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => PromoCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(
          create: (context) => InvoiceCubit(),
        ),
        BlocProvider(
          create: (context) => ContactCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: WelcomePage(),
        routes: {
          '/': (context) => WelcomePage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/main': (context) => MainPage(),
          // '/list-address': (context) => AddressPage(),
        },
      ),
    );
  }
}
