import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class AccountMenuContainer extends StatelessWidget {
  final String titleName;
  final Icon icon;
  final Function() onPress;
  const AccountMenuContainer({
    Key? key,
    required this.titleName,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              child: Row(
                children: <Widget>[
                  icon,
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    titleName,
                    style: blackTextStyle,
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
