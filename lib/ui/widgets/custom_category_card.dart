import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/shared/theme.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final Function() onPress;
  const CustomCategoryCard({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        // padding: EdgeInsets.all(5),
        // height: 200,
        width: 100,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 3, color: kChocolateColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Text('Image not Found !');
                  },
                ),
              ),
            ),
            Text(
              title,
              style: chocolateTextStyle.copyWith(fontWeight: semiBold),
            )
          ],
        ),
      ),
    );
  }
}
