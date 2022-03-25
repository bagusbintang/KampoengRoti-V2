import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/faq_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class FaqCard extends StatelessWidget {
  final FaqModel faqModel;
  const FaqCard({Key? key, required this.faqModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: faqModel.number.toString().padLeft(2, "0"),
                style:
                    chocolateTextStyle.copyWith(fontSize: 12, fontWeight: bold),
              ),
              TextSpan(
                text: "  " + faqModel.title!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        children: [
          ListTile(
            title: Text(
              faqModel.desc!,
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          )
        ],
      ),
    );
  }
}
