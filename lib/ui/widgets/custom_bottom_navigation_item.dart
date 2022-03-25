import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String title;
  const CustomBottomNavigationItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
            color: context.read<PageCubit>().state == index
                ? kChocolateColor
                : kDarkGreyColor,
          ),
          Text(
            title,
            style: context.read<PageCubit>().state == index
                ? chocolateTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  )
                : darkGreyTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
          ),
        ],
      ),
    );
  }
}
