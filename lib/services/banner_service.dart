import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/banner_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class BannerService {
  Future<List<BannerModel>> getBanner() async {
    Uri url = Uri.parse(getBannerUrl);
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<BannerModel> banners = [];

        for (var item in data) {
          banners.add(BannerModel.fromJson(item));
        }

        return banners;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Banner : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Banner: ' + response.body);
    }
  }
}
