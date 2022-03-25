import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/invoice_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class OrderService {
  Future<void> checkOut({
    required int userId,
    required int deliveryMethod,
    int? addressId,
    required int outletId,
    required int promoId,
    required double shippingCosts,
    required double promoDisc,
    required double memberDisc,
    required String deliveryTime,
    required String paymenMethod,
    required String note,
    required double total,
    required double grandTotal,
  }) async {
    var body = jsonEncode({
      'delivery_method': deliveryMethod,
      'caddress_id': addressId,
      'outlet_id': outletId,
      'promoid': promoId,
      'ongkir': shippingCosts,
      'promodiscount': promoDisc,
      'memberdiscount': memberDisc,
      'deliverytime': deliveryTime,
      'payment_method': paymenMethod,
      'note': note,
      'total': total,
      'grandtotal': grandTotal,
    });

    var response = await http.post(
      Uri.parse("$checkoutUrl/${userId}"),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      print(data);
    } else {
      throw Exception('Gagal Mengirim data Invoice: ' + response.body);
    }
  }

  Future<List<InvoiceModel>> getInvoice({
    required int userId,
    required int status,
  }) async {
    final url = Uri.encodeFull("$getInvoiceUrl/${userId}/${status}");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<InvoiceModel> invoice = [];

      for (var item in data) {
        // if  (item.containsKey()){}
        invoice.add(InvoiceModel.fromJson(item));
      }

      return invoice;
    } else {
      throw Exception('Gagal mendapat kan data Invoice: ' + response.body);
    }
  }
}
