import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class CustomDeliveryMenu extends StatelessWidget {
  final String title;
  final String body;
  final Function() onPress;
  const CustomDeliveryMenu({
    Key? key,
    required this.title,
    required this.body,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: kWhiteColor),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: darkGreyTextStyle.copyWith(fontSize: 10),
              ),
            ),
            Container(
              child: Text(
                body,
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
