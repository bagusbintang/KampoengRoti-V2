import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class OutletService {
  Future<List<OutletModel>> getOutlets({
    required int cityId,
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.encodeFull("$outletUrl/${cityId}/${latitude}/${longitude}");
    // var params = {
    //   "city_id": cityId.toString(),
    // };
    // Uri uri = Uri.parse(outletUrl);
    // final newURI = uri.replace(queryParameters: params);

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<OutletModel> outlets = [];

        for (var item in data) {
          outlets.add(OutletModel.fromJson(item));
        }

        return outlets;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Outlet : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Outlet: ' + response.body);
    }
  }
}
