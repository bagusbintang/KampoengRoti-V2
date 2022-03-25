import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampoeng_roti2/cubit/user_address_cubit.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/shared/theme.dart';
import 'package:kampoeng_roti2/shared/user_singleton.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/address_page.dart';
import 'package:kampoeng_roti2/ui/pages/address_page/component/custom_input_text_address.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kampoeng_roti2/ui/widgets/custom_button.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({Key? key}) : super(key: key);

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  UserModel user = UserSingleton().user;
  TextEditingController? tagNameController;
  TextEditingController? pinLocationController;
  TextEditingController? detailAddressController;
  TextEditingController? phoneController;
  TextEditingController? notesController;

  UserAddressModel? addressModel;
  String? _address;
  bool _checkBoxValue = false;
  List<Placemark>? _placemarks;

  void _getPlace(LatLng latLng) async {
    _placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    Placemark placemark = _placemarks![0];
    _address = "${placemark.street}, " + //nama jalan
        "${placemark.subLocality}, " + //nama sektor
        "${placemark.locality}, " + //nama kecamatan
        "${placemark.subAdministrativeArea}, " + //nama kota
        "${placemark.administrativeArea}, "; // nama provinsi

    pinLocationController!.text = _address!;
    addressModel!.address = _address;
    addressModel!.city = placemark.subAdministrativeArea;
    addressModel!.province = placemark.administrativeArea;
  }

  @override
  void dispose() {
    tagNameController!.dispose();
    pinLocationController!.dispose();
    detailAddressController!.dispose();
    phoneController!.dispose();
    notesController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final int userId = ModalRoute.of(context)!.settings.arguments as int;
    addressModel =
        ModalRoute.of(context)!.settings.arguments as UserAddressModel;

    if (addressModel!.defaultAddress == 1) {
      _checkBoxValue = true;
    }

    tagNameController =
        TextEditingController(text: addressModel!.tagAddress ?? '');

    pinLocationController =
        TextEditingController(text: addressModel!.address ?? '');

    detailAddressController =
        TextEditingController(text: addressModel!.addressDetail ?? '');

    phoneController =
        TextEditingController(text: addressModel!.personPhone ?? '');

    notesController = TextEditingController(text: addressModel!.notes ?? '');

    Widget inputSection() {
      const kGoogleApiKey = "AIzaSyDFo_3wbFmTfFHuaivN56QOyupSdnkSeis";

      GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
      Future<Null> displayPrediction(Prediction p) async {
        if (p != null) {
          PlacesDetailsResponse detail =
              await _places.getDetailsByPlaceId(p.placeId!);
          var placeId = p.placeId;
          double lat = detail.result.geometry!.location.lat;
          double lng = detail.result.geometry!.location.lng;

          // var address =
          //     await Geocoder.local.findAddressesFromQuery(p.description);

          addressModel!.latitude = lat;
          addressModel!.longitude = lng;

          print(lat);
          print(lng);
          _getPlace(LatLng(lat, lng));
        }
      }

      Widget tagAlamat() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextAddress(
            title: 'Tag Alamat',
            hint: 'Contoh: Rumah, Kantor',
            inputType: TextInputType.name,
            controller: tagNameController,
          ),
        );
      }

      Widget pinLocation() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () async {
              Prediction? p = await PlacesAutocomplete.show(
                strictbounds: false,
                context: context,
                apiKey: kGoogleApiKey,
                mode: Mode.overlay,
                language: "id",
                components: [Component(Component.country, "id")],
                types: ["address"],
              );
              if (p != null) {
                displayPrediction(p);
              }
            },
            child: CustomInputTextAddress(
              title: 'Alamat',
              hint: 'Alamat',
              inputType: TextInputType.name,
              controller: pinLocationController,
              enable: false,
              maxLine: 4,
            ),
          ),
        );
      }

      Widget detailAlamat() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextAddress(
            title: 'Detail Alamat',
            hint: 'Contoh: Nomor Unit, Lantai Gedung',
            inputType: TextInputType.name,
            controller: detailAddressController,
            maxLine: 3,
          ),
        );
      }

      Widget phone() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextAddress(
            title: 'Telepon',
            hint: 'Telepon',
            inputType: TextInputType.number,
            controller: phoneController,
          ),
        );
      }

      Widget notes() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomInputTextAddress(
            title: 'Catatan',
            hint: 'Pesan untuk Bagian Pengiriman',
            inputType: TextInputType.text,
            controller: notesController,
          ),
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            tagAlamat(),
            pinLocation(),
            detailAlamat(),
            phone(),
            notes(),
          ],
        ),
      );
    }

    Widget buttonDefaultAddress() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 50,
              height: 50,
              child: Checkbox(
                value: _checkBoxValue,
                activeColor: kDarkGreyColor,
                onChanged: (bool? newValue) {
                  setState(() {
                    _checkBoxValue = newValue!;
                    // print(newValue.toString());
                    if (newValue == true) {
                      addressModel!.defaultAddress = 1;
                    } else {
                      addressModel!.defaultAddress = 0;
                    }
                  });
                },
              ),
            ),
            Text(
              "Jadikan Alamat Utama",
              style: darkGreyTextStyle,
            ),
          ],
        ),
      );
    }

    Widget buttonSave() {
      return BlocConsumer<UserAddressCubit, UserAddressState>(
        listener: (context, state) {
          if (state is UserAddressModelSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressPage(),
                ));
          } else if (state is UserAddressFailed) {
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
          if (state is UserAddressLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: defaultMargin,
            ),
            child: CustomButton(
              title: 'TAMBAH ALAMAT',
              onpress: () {
                if (tagNameController.toString().isEmpty &&
                    pinLocationController.toString().isEmpty &&
                    phoneController.toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        "Nama Alamat, Pin Lokasi, Telepon tidak boleh kosong",
                        style: blackTextStyle,
                      ),
                    ),
                  );
                } else {
                  context.read<UserAddressCubit>().editUserAddress(
                        // userId: userId,
                        addressId: addressModel!.id,
                        tagAddress: tagNameController!.text,
                        detailAddress: detailAddressController!.text,
                        personPhone: phoneController!.text,
                        notes: notesController!.text,
                        address: pinLocationController!.text,
                        province: addressModel!.province,
                        city: addressModel!.city,
                        latitude: addressModel!.latitude,
                        longitude: addressModel!.longitude,
                        defaultAddress: addressModel!.defaultAddress,
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
          "Tambah Alamat",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        leading: BackButton(
          color: kBlackColor,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressPage(),
                ));
          },
        ),
        centerTitle: true,
        backgroundColor: kGreyColor,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddressPage(),
              ));
          return false;
        },
        child: ListView(
          children: [
            inputSection(),
            buttonDefaultAddress(),
            buttonSave(),
          ],
        ),
      ),
    );
  }
}
