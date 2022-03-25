import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/cubit/page_cubit.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/account_page/component/custom_inpu_text_edit_page.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class AccountEditProfilPage extends StatefulWidget {
  final UserModel user;
  const AccountEditProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AccountEditProfilPage> createState() => _AccountEditProfilPageState();
}

class _AccountEditProfilPageState extends State<AccountEditProfilPage> {
  TextEditingController? personNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;

  @override
  void dispose() {
    super.dispose();
    personNameController!.dispose();
    emailController!.dispose();
    phoneController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    personNameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone ?? '0');

    Widget inputSection() {
      Widget nameInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextEditPage(
            hint: 'Nama Pengguna',
            inputType: TextInputType.name,
            controller: personNameController,
          ),
        );
      }

      Widget emailInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextEditPage(
            hint: 'Email',
            inputType: TextInputType.name,
            controller: emailController,
          ),
        );
      }

      Widget phoneInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextEditPage(
            hint: 'Nomor Telepon',
            inputType: TextInputType.number,
            controller: phoneController,
          ),
        );
      }

      return Container(
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            phoneInput(),
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<PageCubit>().setPage(4);
            Navigator.pushNamedAndRemoveUntil(
                context, '/main', (route) => false);
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kPrimaryColor,
                content: Text(
                  state.error,
                  style: blackTextStyle,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: CustomButton(
              title: 'SIMPAN',
              onpress: () {
                if (personNameController!.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'nama tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else if (emailController!.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'email tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else if (phoneController!.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'Telepon tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else {
                  context.read<AuthCubit>().editProfile(
                        userId: widget.user.id!,
                        name: personNameController!.text,
                        email: emailController!.text,
                        phone: phoneController!.text,
                      );
                }
              },
              color: kPrimaryColor,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ubah Profil",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: kBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        children: [
          inputSection(),
          buttonSubmit(),
        ],
      ),
    );
  }
}
