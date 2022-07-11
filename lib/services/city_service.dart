import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/city_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class CityService {
  Future<List<CityModel>> getCity({
    int? provinceId,
  }) async {
    Uri url = Uri.parse("$cityUrl/${provinceId}");
    var response = await http.get(url, headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<CityModel> city = [];

        for (var item in data) {
          city.add(CityModel.fromJson(item));
        }

        return city;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data City : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data City: ' + response.body);
    }
  }
}
