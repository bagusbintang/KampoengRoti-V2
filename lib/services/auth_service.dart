import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Login status : ' + mssg);
      }
    } else {
      throw Exception('Gagal Login :' + response.body);
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
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Register status : ' + mssg);
      }
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
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Ubah Profil status : ' + mssg);
      }
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
      // return 'Berhasil Mendaftar member !!';
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        return status;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Meregister Member status : ' + mssg);
      }
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
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal refresh status : ' + mssg);
      }
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
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        return status;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal status : ' + mssg);
      }
    } else {
      return 'Gagal !!' + response.body;
    }
  }

  Future<UserModel> forgotPassword({
    // String username,
    required String email,
  }) async {
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      Uri.parse("$forgetPasswordUrl"),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data['respons_res']);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Forget Password status : ' + mssg);
      }
    } else {
      throw Exception('Gagal Forget Password user: ' + response.body);
    }
  }

  Future<void> resendOtp({
    // String username,
    required int userId,
  }) async {
    var response = await http.post(
      Uri.parse("$resendOtpUrl/${userId}"),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Mendapat OTP status : ' + mssg);
      }
    } else {
      throw Exception('Gagal Mendapat OTP user: ' + response.reasonPhrase!);
    }
  }

  Future<UserModel> submitOtp({
    // String username,
    required int userId,
    required int otp,
  }) async {
    var body = jsonEncode({
      'otp': otp,
    });

    var response = await http.post(
      Uri.parse("$submitOtpUrl/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Mendapat OTP status : ' + mssg);
      }
    } else {
      throw Exception('Gagal Mendapat OTP user: ' + response.body);
    }
  }

  Future<UserModel> resetPassword({
    // String username,
    required int userId,
    required String password,
  }) async {
    var body = jsonEncode({
      'newpassword': password,
    });

    var response = await http.post(
      Uri.parse("$resetPasswordUrl/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var status = jsonDecode(response.body)['meta']['status'];
      if (status == 'sukses') {
        var data = jsonDecode(response.body)['data'];
        UserModel user = UserModel.fromJson(data);

        return user;
      } else {
        var mssg = jsonDecode(response.body)['meta']['message'];
        throw Exception('Gagal Reset Password status : ' + mssg);
      }
    } else {
      throw Exception('Gagal reser password user: ' + response.body);
    }
  }
}
