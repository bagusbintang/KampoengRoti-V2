import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class UserAddressService {
  Future<List<UserAddressModel>> getAddress({
    int userId = 1,
  }) async {
    Uri url = Uri.parse("$listUserAddressUrl/${userId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<UserAddressModel> userAddress = [];

        for (var item in data) {
          userAddress.add(UserAddressModel.fromJson(item));
        }

        return userAddress;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Address : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Address: ' + response.body);
    }
  }

  Future<UserAddressModel> addUserAddress({
    int? userId,
    String? tagAddress,
    String? detailAddress,
    String? personPhone,
    String? address,
    String? city,
    String? province,
    String? notes,
    double? latitude,
    double? longitude,
    int? defaultAddress,
  }) async {
    Uri url = Uri.parse("$addUserAddressUrl/${userId}");

    var body = jsonEncode({
      'tag': tagAddress,
      'detail': detailAddress,
      'phone': personPhone,
      'note': notes,
      'address': address,
      'city': city,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'default': defaultAddress,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserAddressModel user = UserAddressModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Menambah data Address : ' + mssg);
      }
    } else {
      throw Exception('Gagal Menambah Address: ' + response.body);
    }
  }

  Future<UserAddressModel> editUserAddress({
    int? addressId,
    String? tagAddress,
    String? detailAddress,
    String? personPhone,
    String? address,
    String? city,
    String? province,
    String? notes,
    double? latitude,
    double? longitude,
    int? defaultAddress,
  }) async {
    Uri url = Uri.parse("$editUserAddressUrl/${addressId}");
    var body = jsonEncode({
      'tag': tagAddress,
      'detail': detailAddress,
      'phone': personPhone,
      'note': notes,
      'address': address,
      'city': city,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'default': defaultAddress,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserAddressModel user = UserAddressModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Menambah data Address : ' + mssg);
      }
    } else {
      throw Exception('Gagal Mengubah Address: ' + response.body);
    }
  }
}
