import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class ProductService {
  Future<List<ProductModel>> getSearchProduct({
    required int outletId,
    required String search,
  }) async {
    Uri url = Uri.parse("$productUrl/0/${search}/${outletId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<ProductModel> products = [];

        for (var item in data) {
          products.add(ProductModel.fromJson(item));
        }

        return products;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Mendapatkan Product, status : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Product: ' + response.body);
    }
  }

  Future<List<ProductModel>> getProduct({
    required int catId,
    required int outletId,
    required String search,
  }) async {
    Uri url = Uri.parse("$productUrl/${catId}/${search}/${outletId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<ProductModel> products = [];

        for (var item in data) {
          products.add(ProductModel.fromJson(item));
        }

        return products;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Mendapatkan Product, status : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data Product: ' + response.body);
    }
  }

  Future<List<ProductModel>> getNewProduct({
    int? outletId,
  }) async {
    Uri url = Uri.parse("$newProductUrl/${outletId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<ProductModel> products = [];

        for (var item in data) {
          products.add(ProductModel.fromJson(item));
        }

        return products;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Mendapatkan Product, status : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data New Product: ' + response.body);
    }
  }
}
