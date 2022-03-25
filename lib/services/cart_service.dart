import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/cart_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class CartService {
  Future<List<CartModel>> getCart({
    int userId = 1,
  }) async {
    Uri url = Uri.parse("$getCartUrl/${userId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<CartModel> cartList = [];

      for (var item in data) {
        cartList.add(CartModel.fromJson(item));
      }

      return cartList;
    } else {
      throw Exception('Gagal mendapat kan data Cart!');
    }
  }

  Future<CartModel> addCart({
    required int userId,
    required int prodId,
    int quantity = 1,
  }) async {
    Uri url = Uri.parse("$addCartUrl/${userId}/${prodId}");
    var body = jsonEncode({
      'qty': quantity,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CartModel cartModel = CartModel.fromJson(data['respons_res']);

      return cartModel;
    } else {
      throw Exception('Gagal Menambah Cart');
    }
  }

  Future<CartModel> editCart({
    required int cartId,
    // int prodId,
    required int quantity,
    String notes = '',
  }) async {
    Uri url = Uri.parse("$updateCartUrl/${cartId}");
    var body = jsonEncode({
      'qty': quantity,
      'notes': notes,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CartModel cartModel = CartModel.fromJson(data['respons_res']);

      return cartModel;
    } else {
      throw Exception('Gagal Mengubah Cart');
    }
  }

  Future<void> deleteCart({
    required int cartId,
  }) async {
    Uri url = Uri.parse("$deleteCartUrl/${cartId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body)['data'];
      // CartModel cartModel = CartModel.fromJson(data['respons_res']);

      // return cartModel;
      // return "Berhasil Menghapus";
    } else {
      throw Exception('Gagal Menghapus Cart');
    }
  }
}
