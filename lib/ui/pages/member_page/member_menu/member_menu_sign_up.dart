import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti2/cubit/auth_cubit.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/ui/pages/member_page/component/custom_input_text_member.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MemberMenuSignUp extends StatefulWidget {
  final UserModel user;
  final bool fromSignUpPage;
  const MemberMenuSignUp({
    Key? key,
    required this.user,
    this.fromSignUpPage = false,
  }) : super(key: key);

  @override
  State<MemberMenuSignUp> createState() => _MemberMenuSignUpState();
}

class _MemberMenuSignUpState extends State<MemberMenuSignUp> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController numberController = TextEditingController(text: '');
  TextEditingController dateController = TextEditingController(text: '');
  DateTime datenow = DateTime.now();
  DateTime selectDate = DateTime.now();
  var formatDate = DateFormat('d MMMM yyyy');
  XFile? _image;

  bool isEnable = true;

  final ImagePicker _picker = ImagePicker();

  ProgressDialog? pr;
  // _imgFromCamera() async {
  //   XFile? image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image = image as File?;
  //   });
  // }

  // _imgFromGallery() async {
  //   XFile? image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = image as File?;
  //   });
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _image = image;
                        });
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      final XFile? photo =
                          await _picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        _image = photo;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pr = ProgressDialog(context, type: ProgressDialogType.normal);

    //Optional
    pr!.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: kWhiteColor,
      progressWidget: CircularProgressIndicator(
        color: kChocolateColor,
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: primaryTextStyle,
      messageTextStyle: blackTextStyle.copyWith(fontWeight: semiBold),
    );

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: kWhiteColor,
              ),
              child: Image(
                image: AssetImage(
                  "assets/kr_logo.png",
                ),
                height: 50,
                width: 50,
              ),
            ),
            Text(
              "Member\nKampoeng Roti",
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(fontSize: 22, fontWeight: bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "*BIAYA 50.000 / SELAMANYA",
              style: whiteTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextMember(
            icon: Icon(Icons.person),
            hint: 'Nama Lengkap',
            inputType: TextInputType.name,
            controller: nameController,
            enable: isEnable,
          ),
        );
      }

      Widget addressInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextMember(
            icon: Icon(Icons.mail),
            hint: 'Alamat',
            inputType: TextInputType.name,
            controller: addressController,
            enable: isEnable,
          ),
        );
      }

      Widget birthdayInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              if (isEnable) {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1970, 12, 31),
                    maxTime: DateTime(2005, 12, 31),
                    theme: DatePickerTheme(
                        headerColor: kPrimaryColor,
                        backgroundColor: kWhiteColor,
                        itemStyle: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                        doneStyle: blackTextStyle.copyWith(
                          fontSize: 16,
                        )), onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    selectDate = date;
                    dateController.text = formatDate.format(date);
                  });
                }, currentTime: selectDate, locale: LocaleType.id);
              }
            },
            child: CustomInputTextMember(
              icon: Icon(Icons.phone_in_talk_sharp),
              hint: 'Tanggal Lahir',
              inputType: TextInputType.name,
              enable: false,
              controller: dateController,
            ),
          ),
        );
      }

      Widget identityInput() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextMember(
            icon: Icon(Icons.phone_in_talk_sharp),
            hint: 'Nomor Identitas (KTP/SIM)',
            inputType: TextInputType.number,
            controller: numberController,
            enable: isEnable,
          ),
        );
      }

      return Container(
        child: Column(
          children: [
            nameInput(),
            addressInput(),
            birthdayInput(),
            identityInput(),
          ],
        ),
      );
    }

    Widget selectImage() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        // width: 150,
        height: 70,
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: kDarkGreyColor,
          ),
          onPressed: () {
            if (isEnable) {
              _showPicker(context);
            }
          },
          child: Text(
            " + UPLOAD IDENTITAS (KTP/SIM)",
            style: whiteTextStyle.copyWith(fontWeight: black),
          ),
        ),
      );
    }

    Widget showImage() {
      if (_image == null) {
        return SizedBox();
      } else {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
              File((_image!.path)),
              width: double.infinity,
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      }
    }

    Widget buttonSubmit() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            isEnable = true;
            pr!.hide();
            if (widget.fromSignUpPage) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/main', (route) => false);
            }
          } else if (state is AuthFailed) {
            isEnable = true;
            pr!.hide();
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
                color: kChocolateColor,
              ),
            );
          }
          return Container(
            child: CustomButton(
              title: 'DAFTAR SEKARANG',
              onpress: () {
                if (nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'name tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else if (addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'email tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else if (numberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'phone tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else if (dateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        'phone tidak boleh kosong',
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else {
                  isEnable = false;
                  pr!.show();
                  context.read<AuthCubit>().registerMember(
                        userId: widget.user.id!,
                        imageFile: File(_image!.path),
                        name: nameController.text,
                        address: addressController.text,
                        birthdate: selectDate.toString(),
                        noKtp: numberController.text,
                      );
                }
              },
              color: kChocolateColor,
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(
          "DAFTAR",
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        leading: BackButton(
          color: Colors.black,
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
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(10),
            children: [
              header(),
              inputSection(),
              selectImage(),
              showImage(),
              buttonSubmit(),
            ],
          ),
        ],
      ),
    );
  }
}
