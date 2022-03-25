import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class CustomInputTextEditPage extends StatelessWidget {
  // final String title;
  // final Icon icon;
  final String hint;
  final TextInputType inputType;
  final TextEditingController? controller;
  final bool enable;
  final int maxLine;
  const CustomInputTextEditPage({
    Key? key,
    // required this.title,
    // required this.icon,
    required this.hint,
    required this.inputType,
    this.controller,
    this.enable = true,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w500,
        //     fontSize: 14,
        //   ),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        TextFormField(
          // initialValue: initValue,
          enabled: enable,
          controller: controller,
          cursorColor: kDarkGreyColor,
          keyboardType: inputType,
          maxLines: maxLine,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(defaultRadius),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintStyle: TextStyle(color: kDarkGreyColor),
            hintText: hint,
            fillColor: kGreyColor,
          ),
        )
      ],
    );
  }
}
