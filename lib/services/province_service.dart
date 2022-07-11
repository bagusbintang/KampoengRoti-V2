import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/province_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class ProvinceService {
  Future<List<ProvinceModel>> getProvince() async {
    Uri url = Uri.parse(provinceUrl);
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<ProvinceModel> provinces = [];

        for (var item in data) {
          provinces.add(ProvinceModel.fromJson(item));
        }

        return provinces;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Province : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Province: ' + response.body);
    }
  }
}
