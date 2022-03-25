import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/user_address_cubit.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_menu/add_address_page.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_menu/edit_address_page.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/component/address_container.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  UserModel user = UserSingleton().user;
  @override
  void initState() {
    context.read<UserAddressCubit>().getUserAddress(userId: user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget addressList() {
      return BlocConsumer<UserAddressCubit, UserAddressState>(
        listener: (context, state) {
          if (state is UserAddressFailed) {
            // print(state.error);
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
          if (state is UserAddressSuccess) {
            return Container(
              child: Column(
                children: state.address
                    .map((address) => AddressContainer(
                          userAddressModel: address,
                          onPress: () {
                            UserSingleton().address = address;
                            UserSingleton().outlet = address.outletModel!;
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          onEdit: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAddressPage(),
                                  settings: RouteSettings(arguments: address),
                                ));
                          },
                        ))
                    .toList(),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(defaultMargin),
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        },
      );
    }

    Widget buttonAddAddress() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: CustomButton(
          title: '+ TAMBAH ALAMAT BARU',
          onpress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressPage(),
                  settings: RouteSettings(arguments: user.id),
                ));
          },
          color: kPrimaryColor,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Alamat",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        leading: BackButton(
          color: kBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kGreyColor,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          addressList(),
          buttonAddAddress(),
        ],
      ),
    );
  }
}
