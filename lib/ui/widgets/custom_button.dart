import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onpress;
  final EdgeInsets margin;
  final Color color;
  const CustomButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    required this.onpress,
    this.margin = EdgeInsets.zero,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: margin,
      child: TextButton(
        onPressed: onpress,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
