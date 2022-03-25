import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomOutletHeaderContainer extends StatelessWidget {
  final Size size;
  final OutletModel outletModel;
  final Function() onPress;
  const CustomOutletHeaderContainer({
    Key? key,
    required this.size,
    required this.outletModel,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleLaunchMap() async {
      if (await canLaunch(outletModel.url ?? "")) {
        await launch(outletModel.url ?? "");
      } else {
        throw 'Could not open the map.';
      }
    }

    return InkWell(
      onTap: onPress,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: kDarkGreyColor),
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            RawMaterialButton(
              onPressed: null,
              elevation: 2.0,
              fillColor: kPrimaryColor,
              child: Icon(
                Icons.location_on_outlined,
                color: kWhiteColor,
              ),
              padding: EdgeInsets.zero,
              shape: CircleBorder(),
            ),
            Text(
              outletModel.title ?? ''.toUpperCase(),
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            Text(
              outletModel.address ?? '',
              style: blackTextStyle,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            Text(
              "Telp :" + "${outletModel.phone ?? ''}",
              style: blackTextStyle,
            ),
            InkWell(
              onTap: handleLaunchMap,
              child: Text(
                "LIHAT PETA --->",
                style: chocolateTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
