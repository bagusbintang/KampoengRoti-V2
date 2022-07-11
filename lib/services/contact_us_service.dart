import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti2/models/contact_us_model.dart';
import 'package:kampoeng_roti2/services/services.dart';

class ContactUsService {
  Future<ContactUsModel> getCcontact() async {
    Uri url = Uri.parse(getContactUs);
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        ContactUsModel contact = ContactUsModel.fromJson(data['respons_res']);

        return contact;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal mendapat kan data contact : ' + mssg);
      }
    } else {
      throw Exception('Gagal get contact : ' + response.body);
    }
  }
}
