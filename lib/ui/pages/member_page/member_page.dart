import 'package:flutter/material.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/member_menu/member_register_page.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/member_menu/member_unregister_page.dart';

class MemberPage extends StatelessWidget {
  final UserModel user;
  const MemberPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Member Kampoeng Roti",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: kBlackColor,
          onPressed: () {
            // Get.back();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kGreyColor,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/kr_background2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          user.memberNo != null
              ? MemberRegisterPage(
                  size: size,
                  user: user,
                )
              : MemberUnregisterPage(
                  size: size,
                  user: user,
                ),
        ],
      ),
    );
  }
}
