import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class AddressContainer extends StatelessWidget {
  final UserAddressModel userAddressModel;
  final Function() onPress;
  final Function() onEdit;
  const AddressContainer({
    Key? key,
    required this.userAddressModel,
    required this.onPress,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool mainAddress = false;
    if (userAddressModel.defaultAddress == 0) {
      mainAddress = false;
    } else {
      mainAddress = true;
    }
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userAddressModel.tagAddress!.toUpperCase(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  Visibility(
                    visible: mainAddress,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.done,
                              size: 12,
                              color: kPrimaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "Alamat Utama",
                            style:
                                primaryTextStyle.copyWith(fontWeight: semiBold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   widget.userAddres.personName,
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            Text(
              userAddressModel.address!,
              style: blackTextStyle.copyWith(fontWeight: medium),
              overflow: TextOverflow.clip,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No. Telpon : ${userAddressModel.personPhone!}",
                    style: blackTextStyle.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            "edit",
                            style:
                                primaryTextStyle.copyWith(fontWeight: medium),
                          ),
                          ImageIcon(
                            AssetImage(
                              "assets/icon_writing.png",
                            ),
                            color: kPrimaryColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
