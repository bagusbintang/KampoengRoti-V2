import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/outlet_cubit.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_outlet_container.dart';

class OutletsPage extends StatefulWidget {
  const OutletsPage({Key? key}) : super(key: key);

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  @override
  void initState() {
    context.read<OutletCubit>().fetchOutlet(
        latitude: UserSingleton().user.defaulAdress!.latitude ?? 0,
        longitude: UserSingleton().user.defaulAdress!.longitude ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final TextEditingController searchController =
        TextEditingController(text: '');

    Widget header() {
      return Container(
        height: size.height / 2.4,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height / 3,
              width: size.width,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(size.width, 150))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kPrimaryColor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kWhiteColor,
                  ),
                  child: Image(
                    image: AssetImage(
                      "assets/kr_logo.png",
                    ),
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ),
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
                    return CustomOutlerContainer(
                        size: size, outletModel: outlet);
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
      backgroundColor: kTransparentColor,
      body: ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          header(),
          titleAndSearch(),
          outlets(),
        ],
      ),
    );
  }
}
