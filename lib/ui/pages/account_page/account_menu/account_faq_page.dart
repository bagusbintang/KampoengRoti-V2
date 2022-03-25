import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/faq_cubit.dart';
import 'package:kampoeng_roti2/models/faq_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_faq_card.dart';

class AccountFaqPage extends StatefulWidget {
  const AccountFaqPage({Key? key}) : super(key: key);

  @override
  State<AccountFaqPage> createState() => _AccountFaqPageState();
}

class _AccountFaqPageState extends State<AccountFaqPage> {
  Map<FaqModel, bool> expanded = {};
  @override
  void initState() {
    context.read<FaqCubit>().fetchFaqs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 70,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: kPrimaryColor,
          child: Column(
            children: [
              Text(
                "Frequently Asked Questions",
                textAlign: TextAlign.center,
                style: whiteTextStyle.copyWith(fontWeight: semiBold),
              ),
              Text(
                "Silahkan membaca FAQ kami sebelum bertanya lebih lanjut",
                style: whiteTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      return BlocConsumer<FaqCubit, FaqState>(
        listener: (context, state) {
          if (state is FaqFailed) {
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
          if (state is FaqSuccess) {
            return Container(
              child: Column(
                children: state.faqs
                    .map((FaqModel faq) => FaqCard(faqModel: faq))
                    .toList(),
              ),
            );
          }

          return Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQ",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            body(),
          ],
        ),
      ),
    );
  }
}
