import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/faq_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class FaqService {
  Future<List<FaqModel>> getFaq() async {
    var response = await http.get(Uri.parse(faqUrl), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        List data = jsonDecode(response.body)['data']['respons_res'];
        List<FaqModel> faqs = [];

        for (var item in data) {
          faqs.add(FaqModel.fromJson(item));
        }

        return faqs;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data FAQ : ' + mssg);
      }
    } else {
      throw Exception('Gagal mendapat kan data FAQ: ' + response.body);
    }
  }
}
