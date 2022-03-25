import 'package:flutter/material.dart';

class CustomButtonDelivery extends StatelessWidget {
  final String text;
  final Function() onPress;
  final Color backgroundColor;
  final TextStyle textStyle;
  const CustomButtonDelivery({
    Key? key,
    required this.text,
    required this.onPress,
    required this.backgroundColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: backgroundColor,
          ),
          onPressed: onPress,
          child: Text(
            text.toUpperCase(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
