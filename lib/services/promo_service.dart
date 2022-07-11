import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/promo_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class PromoService {
  Future<List<PromoModel>> getPromo({
    int userId = 0,
  }) async {
    Uri url = Uri.parse("$getPromoUrl");
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<PromoModel> promos = [];

        for (var item in data) {
          promos.add(PromoModel.fromJson(item));
        }

        return promos;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Promo : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Promo: ' + response.body);
    }
  }
}
