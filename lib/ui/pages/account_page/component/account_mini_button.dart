import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class AccountMiniButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const AccountMiniButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
