import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/invoice_cubit.dart';
import 'package:kampoeng_roti2/models/invoice_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/account_invoice_container.dart';

class AccountInvoicePage extends StatefulWidget {
  const AccountInvoicePage({Key? key}) : super(key: key);

  @override
  State<AccountInvoicePage> createState() => _AccountInvoicePageState();
}

class _AccountInvoicePageState extends State<AccountInvoicePage> {
  List<String> categoryStatus = [
    // "Menunggu Pembayaran",
    "Pesanan Diproses",
    "Pesanan Dikirim",
    "Pesanan Selesai"
  ];
  int selectedIndex = 0;
  @override
  void initState() {
    context.read<InvoiceCubit>().fetchInvoice(
          userId: UserSingleton().user.id!,
          status: selectedIndex + 2,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget category() {
      Widget buildCategory(int index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                context.read<InvoiceCubit>().fetchInvoice(
                      userId: UserSingleton().user.id!,
                      status: selectedIndex + 2,
                    );
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(color: kBlackColor),
                color: selectedIndex == index
                    ? kChocolateColor
                    : kTransparentColor,
              ),
              child: Center(
                child: Text(
                  categoryStatus[index],
                  style:
                      selectedIndex == index ? whiteTextStyle : blackTextStyle,
                ),
              ),
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(vertical: defaultMargin, horizontal: 8),
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryStatus.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      );
    }

    Widget invoiceBody({required List<InvoiceModel> invoiceList}) {
      return Container(
        child: Column(
          children: invoiceList
              .map((invoice) => AccountInvoiceContainer(
                    invoice: invoice,
                  ))
              .toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kGreyColor.withOpacity(1),
      appBar: AppBar(
        title: Text(
          "Daftar Transaksi",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 0.0,
      ),
      body: BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceFailed) {
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
          if (state is InvoiceSuccess) {
            return ListView(
              children: [
                category(),
                Divider(
                  thickness: 1,
                ),
                invoiceBody(invoiceList: state.invoice),
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
