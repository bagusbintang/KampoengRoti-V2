import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/promo_cubit.dart';
import 'package:kampoeng_roti2/models/promo_model.dart';
import 'package:kampoeng_roti2/shared/promo_singleton.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/component/promo_container.dart';
import 'package:kampoeng_roti2/ui/pages/promo_page/promo_detail_page.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  void initState() {
    context.read<PromoCubit>().fetchPromo(userId: UserSingleton().user.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget promoList(List<PromoModel> list) {
      return Container(
        child: Column(
          children: list
              .map((PromoModel promo) => PromoContainer(
                    promoModel: promo,
                    onPress: () {
                      // PromoSingleton().promo = promo;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PromoDetailPage(
                            promo: promo,
                            // used: false,
                          ),
                        ),
                      );
                    },
                  ))
              .toList(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promo Kampoeng Roti",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kGreyColor,
        elevation: 0.0,
      ),
      body: BlocConsumer<PromoCubit, PromoState>(
        listener: (context, state) {
          if (state is PromoFailed) {
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
          if (state is PromoSuccess) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              children: [
                promoList(state.promoList),
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
}
