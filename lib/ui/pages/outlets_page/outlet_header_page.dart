import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/outlet_cubit.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_outlet_header_container.dart';

class OutletHeaderPage extends StatefulWidget {
  const OutletHeaderPage({Key? key}) : super(key: key);

  @override
  State<OutletHeaderPage> createState() => _OutletHeaderPageState();
}

class _OutletHeaderPageState extends State<OutletHeaderPage> {
  UserAddressModel address = UserSingleton().address;
  @override
  void initState() {
    context.read<OutletCubit>().fetchOutlet(
        latitude: address.latitude ?? 0, longitude: address.longitude ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final TextEditingController searchController =
        TextEditingController(text: '');

    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                "assets/kr_logo.png",
              ),
              height: 150,
              width: 150,
            ),
            // textFieldSearchOutlets(
            //     "Cari Outlets", Icon(Icons.search)),
          ],
        ),
      );
    }

    Widget titleAndSearch() {
      Widget searchInput() {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: TextFormField(
            textAlign: TextAlign.center,
            cursorColor: kDarkGreyColor,
            controller: searchController,
            obscureText: false,
            onChanged: (value) {
              if (value != null && value != '') {
                if (value.length >= 3) {}
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
                hintText: 'Cari Outlet',
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

      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "OUTLET",
              style: chocolateTextStyle.copyWith(
                fontSize: 40,
                fontWeight: bold,
              ),
            ),
            // searchInput(),
          ],
        ),
      );
    }

    Widget outlets() {
      return BlocConsumer<OutletCubit, OutletState>(
        listener: (context, state) {
          if (state is OutletFailed) {
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
          if (state is OutletSuccess) {
            return Container(
              margin:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: state.outlets.map((OutletModel outlet) {
                    return CustomOutletHeaderContainer(
                      size: size,
                      outletModel: outlet,
                      onPress: () {
                        UserSingleton().outlet = outlet;
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        },
      );
    }

    return Scaffold(
      // backgroundColor: kTransparentColor,
      appBar: AppBar(
        title: Text(
          "PILIH OUTLET",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/kr_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(bottom: 50),
            children: [
              header(),
              titleAndSearch(),
              outlets(),
            ],
          ),
        ],
      ),
    );
  }
}
