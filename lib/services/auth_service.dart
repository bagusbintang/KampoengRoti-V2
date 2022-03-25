import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kampoeng_roti2/models/user_model.dart';
import 'package:kampoeng_roti2/services/services.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AuthService {
  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    Uri url = Uri.parse(loginUrl);
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);
      return user;
    } else {
      throw Exception('Gagal Login : ' + response.body);
    }
  }

  Future<UserModel> register({
    String? username,
    String? email,
    String? phone,
    String? password,
    double? lat,
    double? long,
  }) async {
    Uri url = Uri.parse(registerUrl);
    var body = jsonEncode({
      'name': username,
      'email': email,
      'phone': phone,
      'password': password,
      'latitude': lat,
      'longitude': long,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Register :' + response.body);
    }
  }

  Future<UserModel> updateProfile({
    int? userId,
    String? name,
    String? email,
    String? phone,
  }) async {
    var body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
    });
    Uri url = Uri.parse("$getUpdateUserUrl/${userId}");
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal Mengubah Profil : ' + response.body);
    }
  }

  Future<String> registerMember({
    int? userId,
    File? imageFile,
    String? name,
    String? address,
    String? birthdate,
    String? noKtp,
  }) async {
    // var body = jsonEncode({
    //   'name': name,
    //   'email': email,
    //   'phone': phone,
    // });
    Uri url = Uri.parse("$registerMemberUrl/${userId}");
    final mimeTypeData =
        lookupMimeType(imageFile!.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', url);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('img_ktp', imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    // var fileStream =
    //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // var length = await imageFile.length();
    // var request = new http.MultipartRequest(
    //     "POST", Uri.parse("$registerMemberUrl/${userId}"));
    //add your fields here
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['no_ktp'] = noKtp!;
    imageUploadRequest.fields['birthdate'] = birthdate!;
    imageUploadRequest.fields['member_address'] = address!;
    imageUploadRequest.fields['member_full_name'] = name!;

    // var multipartFile = new http.MultipartFile('img_ktp', fileStream, length,
    //     filename: "test.${imageFile.path.split(".").last}");
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    // var response = await imageUploadRequest.send();
    print(response);
    if (response.statusCode == 200) {
      return 'Berhasil Mendaftar member !!';
    } else {
      throw Exception('Gagal Meregister Member: ' + response.body);
    }
  }

  Future<UserModel> refreshUser({
    // String username,
    int? userId,
  }) async {
    // var body = jsonEncode({
    //   // 'name': username,
    //   'email': email,
    //   'password': password,
    // });
    Uri url = Uri.parse("$getUserById/${userId}");
    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['respons_res']);

      return user;
    } else {
      throw Exception('Gagal refresh user: ' + response.body);
    }
  }

  Future<String> registerMemberNo({
    // String username,
    required int userId,
    required String memberNo,
  }) async {
    var body = jsonEncode({
      'member_no': memberNo,
    });

    var response = await http.post(
      Uri.parse("$getUserById/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return 'Berhasil !!';
    } else {
      return 'Gagal !!' + response.body;
    }
  }
}
