import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/category_mode.dart';
import 'package:kampoeng_roti2/services/services.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategory({
    int? outletId,
  }) async {
    Uri url = Uri.parse("$categoryUrl/${outletId!}");
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<CategoryModel> categories = [];

        for (var item in data) {
          categories.add(CategoryModel.fromJson(item));
        }

        return categories;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data Category : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Category: ' + response.body);
    }
  }
}
